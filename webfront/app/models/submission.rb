class Submission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :solution_path

  embeds_many :runs
end
