require 'bunny'

class AgentConnection
  def run_script(input_file_name, output_file_name)
    message = {input: input_file_name, output: output_file_name }
    Bunny.run { |b| b.exchange("").publish BSON.serialize(message), key: 'scripts' }
  end
end
