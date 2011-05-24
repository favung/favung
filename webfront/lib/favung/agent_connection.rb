require 'net/http'

class AgentConnection
  def run_script(input_file_name, output_file_name)
    channel = '/scripts'
    message = {:channel => channel, :data => { :input => input_file_name, :output => output_file_name }}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
