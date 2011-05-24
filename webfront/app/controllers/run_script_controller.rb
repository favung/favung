class RunScriptController < ApplicationController
  def index
  end

  def show
    @output = GridFileSystemHelper::read_file(params[:id])
  end

  def run
    GridFileSystemHelper::store_file("solution.txt", params[:script][:script])

    agent = AgentConnection.new
    output_path = "output"
    agent.run_script("solution.txt", output_path)
    redirect_to show_result_path(output_path)
  end
end
