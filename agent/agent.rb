require 'drb'


require 'mongo'

connection = Mongo::Connection.new
$db = connection.db('favung_development')

class Agent
  def execute(gridfs_path)
    script_file = Mongo::GridFileSystem.new($db).open(gridfs_path, 'r')
    script = script_file.read
    script_file.close

    output = `ruby -e "#{script}"`

    output_file = Mongo::GridFileSystem.new($db).open("output.txt", 'w')
    output_file.write output
    output_file.close

    "output.txt"
  end
end

DRb.start_service nil, Agent.new
puts DRb.uri

DRb.thread.join
