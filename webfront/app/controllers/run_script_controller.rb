require 'drb'

class RunScriptController < ApplicationController
  def index
  end

  def run
    DRb.start_service
    agent = DRbObject.new nil, params[:script][:service_url]
    @output = agent.execute(params[:script][:script])
  end
end
