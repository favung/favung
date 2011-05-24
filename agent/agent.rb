require 'drb'

class Agent
  def execute(script)
    `ruby -e "#{script}"`
  end
end

DRb.start_service nil, Agent.new
puts DRb.uri

DRb.thread.join
