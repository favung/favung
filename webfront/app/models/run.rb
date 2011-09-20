class Run
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :submission

  def output
    if GridFileSystemHelper.file_exists?("outputs/#{id.to_s}")
      @output ||= GridFileSystemHelper::read_file("outputs/#{id.to_s}")
    end
  end
end
