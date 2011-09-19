class Run
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :submission
end
