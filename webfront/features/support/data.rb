require 'fileutils'

Before do
  FileUtils.rm_rf(Task::DATA_DIR)
  FileUtils.mkdir_p(Task::TASKS_DIR)
end
