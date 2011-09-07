class Task
  # TODO(doriath) move to initialization
  if Rails.env == "development"
    DATA_DIR = File.join(Rails.root, 'data')
  else
    DATA_DIR = File.join(Rails.root, 'features', 'data')
  end
  TASKS_DIR = File.join(DATA_DIR, 'tasks')

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_param
    name
  end

  def index_path
    File.join(TASKS_DIR, name, 'index')
  end

  def self.find(name)
    if FileHelpers.directories(TASKS_DIR).include? name
      Task.new(name: name)
    end
  end

  def self.all
    tasks = []
    FileHelpers.directories(TASKS_DIR).each do |task_name|
      tasks << Task.new(name: task_name)
    end
    tasks
  end
end

module FileHelpers
  def self.directories(dir_path)
    Dir[File.join(dir_path, '*')].map do |dir_name|
      File.basename(dir_name) if Dir.exists?(dir_name)
    end.compact
  end
end
