require 'mongo'

module GridFileSystemHelper
  def self.store_file(path, content)
    file = Mongo::GridFileSystem.new(Mongoid.database).open(path, 'w')
    file.write content
    file.close
  end

  def self.read_file(path)
    file = Mongo::GridFileSystem.new(Mongoid.database).open(path, 'r')
    output = file.read
    file.close

    output
  end

  def self.file_exists?(file_name)
    Mongo::GridFileSystem.new(Mongoid.database).exist?(filename: file_name)
  end
end
