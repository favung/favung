require 'drb'
require 'mongo'

class RunScriptController < ApplicationController
  def index
  end

  def run
    gridfs_path = 'solution.txt'
    gridfs_file = Mongo::GridFileSystem.new(Mongoid.database).open(gridfs_path, 'w')
    gridfs_file.write params[:script][:script]
    gridfs_file.close

    DRb.start_service
    agent = DRbObject.new nil, params[:script][:service_url].chomp
    output_path = agent.execute('solution.txt')

    output_file = Mongo::GridFileSystem.new(Mongoid.database).open(output_path, 'r')
    @output = output_file.read
    output_file.close
  end
end
