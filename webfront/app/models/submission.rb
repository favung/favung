class Submission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :task

  belongs_to :user
  embeds_many :runs

  def source
    @source ||= GridFileSystemHelper::read_file(id.to_s)
  end
end
