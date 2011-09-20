#!/usr/bin/env ruby
require 'mongo'
require 'eventmachine'
require 'yaml'
require 'logger'
require 'amqp'
require 'fileutils'

def load_configuration
  environment = ENV['ENV'] || 'development'
  mongo_configuration = YAML::load_file('config/mongo.yml')
  logger_configuration = YAML::load_file('config/logger.yml')
  amqp_configuration = YAML::load_file('config/amqp.yml')

  return {
    mongo: mongo_configuration[environment],
    logger: logger_configuration[environment],
    amqp: amqp_configuration[environment]
  }
end

configuration = load_configuration
connection = Mongo::Connection.new(configuration[:mongo]["host"])
$db = connection.db(configuration[:mongo]["database"])

$logger = Logger.new(STDOUT)

TMP_DIR = '/tmp/favung'

class CppRunner
  def run(source)
    save_source(source)
    compile
    execute_binary
  end

  def compile
    `g++ source.cpp -o submission`
  end

  def execute_binary
    `./submission`
  end

  def save_source(source)
    File.open('source.cpp', 'w') do |f|
      f.write(source)
    end
  end
end

class RubyRunner
  def run(source)
    `ruby -e "#{source}"`
  end
end

class Agent
  def execute(source_path, output_path, runner_name)
    # TODO(zurkowski) Replace it with something nicer :)
    runner = case runner_name
             when "CppRunner"
               CppRunner.new
             when "RubyRunner"
               RubyRunner.new
             else
               $logger.info "Unknown runner name: #{runner_name}"
             end

    prepare_environment

    output = nil
    Dir.chdir(TMP_DIR) do
      source = Mongo::GridFileSystem.new($db).open(source_path, 'r') {|f| f.read }
      output = runner.run(source)
    end

    output_file = Mongo::GridFileSystem.new($db).open(output_path, 'w')
    output_file.write output
    output_file.close

    puts "== Output =="
    puts output
  end

  def prepare_environment
    FileUtils.rm_rf(TMP_DIR)
    FileUtils.mkdir_p(TMP_DIR)
  end
end

agent = Agent.new

AMQP.start(configuration[:amqp]) do |connection|
  channel = AMQP::Channel.new(connection)
  queue = channel.queue("scripts", auto_delete: true)
  exchange = channel.direct("")
  queue.subscribe do |message|
    message = BSON.deserialize(message)
    $logger.info "Processing script #{message['input']}"
    agent.execute(message["input"], message["output"], message["runner"])
  end
end
