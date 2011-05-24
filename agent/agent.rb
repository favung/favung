require 'drb'

class Agent
  def execute
    "Hello world"
  end
end

DRb.start_service nil, Agent.new
puts DRb.uri

DRb.thread.join
