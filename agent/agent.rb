require 'mongo'
require 'eventmachine'
require 'faye'

connection = Mongo::Connection.new
$db = connection.db('favung_development')

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
    agent.execute(message["input"], message["output"])
  end
}
