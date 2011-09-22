require 'bunny'
require 'yaml'

module AgentConnection
  extend self

  def configure(config)
    @bunny = Bunny.new(config)
    @bunny.start
    @exchange = @bunny.exchange("")
  end

  def run_submission(submission, run)
    message = {input: submission.id.to_s, output: "outputs/#{run.id.to_s}", runner: 'CppRunner'}
    publish message
  end

  private
  def publish(message)
    @exchange.publish BSON.serialize(message), key: 'scripts'
  end
end

config = YAML.load_file("#{Rails.root}/config/amqp.yml") || {}
config = config[Rails.env] || {}

AgentConnection.configure(config)
