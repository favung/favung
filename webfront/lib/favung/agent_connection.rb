require 'drb'

class AgentConnection
  def initialize(service_path)
    @service_path = service_path
  end

  def run_script(input_file_name)
    DRb.start_service
    agent = DRbObject.new nil, @service_path
    agent.execute(input_file_name)
  end

end
