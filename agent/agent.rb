require 'mongo'
require 'eventmachine'
require 'faye'
require 'yaml'
def load_configuration
  environment = ENV['ENV'] || 'development'
  mongo_configuration = YAML::load_file('config/mongo.yml')

  return mongo_configuration[environment]
end


configuration = load_configuration
connection = Mongo::Connection.new(configuration["host"])
$db = connection.db(configuration["database"])

class Agent
  def execute(input_path, output_path)
    script_file = Mongo::GridFileSystem.new($db).open(input_path, 'r')
    script = script_file.read
    script_file.close

    output = `ruby -e "#{script}"`

    output_file = Mongo::GridFileSystem.new($db).open(output_path, 'w')
    output_file.write output
    output_file.close
  end
end


agent = Agent.new
client = Faye::Client.new('http://localhost:9292/faye')
EM.run {
  client.subscribe('/scripts') do |message|
    puts "Processing script #{message['input']}"
    agent.execute(message["input"], message["output"])
  end
}
