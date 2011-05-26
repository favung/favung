class Run
  include Mongoid::Document
  include Mongoid::Timestamps

  field :output_path
  field :error_code, :type => Integer

  embedded_in :submission
end
