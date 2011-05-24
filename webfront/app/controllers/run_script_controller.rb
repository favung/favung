class RunScriptController < ApplicationController
  def index
  end

  def run
    GridFileSystemHelper::store_file("solution.txt", params[:script][:script])

    agent = AgentConnection.new(params[:script][:service_url])
    output_path = agent.run_script("solution.txt")

    @output = GridFileSystemHelper::read_file(output_path)
  end
end
