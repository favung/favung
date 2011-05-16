class RunScriptController < ApplicationController
  def index
  end

  def run
    @output = `ruby -e "#{params[:script][:script]}"`
  end

end
