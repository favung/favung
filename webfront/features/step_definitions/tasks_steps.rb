Given /^one task exists$/ do
  @task = Task.new(name: 'a')
  @task_description = "Task description"
  FileUtils.mkdir(File.join(Task::TASKS_DIR, 'a'))
  File.open(File.join(Task::TASKS_DIR, 'a', 'index.html'), 'w') do |f|
    f.write @task_description
  end
end

Then /^I should see that task$/ do
  page.should have_content @task.name
end

When /^I click on this task$/ do
  click_on @task.name
end

Then /^I should see the description of that task$/ do
  page.should have_content @task_description
end
