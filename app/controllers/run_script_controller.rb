class RunScriptController < ApplicationController
  def index
  end

  def run
    runner = Runners::RubyRunner.new
    @output = runner.run(params[:script][:script])
  end

end
