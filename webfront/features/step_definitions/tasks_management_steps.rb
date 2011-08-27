When /^I fill in the task form$/ do
  @task = Task.new(name: 'Task name', description: 'Task descrption')

  fill_in 'task_name', with: @task.name
  fill_in 'task_description', with: @task.description
  click_on 'task_submit'
end

Then /^the task should be created$/ do
  task = Task.all.first
  task.name.should == @task.name
  task.description.should == @task.description
end

Given /^one task exists$/ do
  @task = Task.create!(name: 'Task name', description: 'Task description')
end

When /^I modify the task description$/ do
  @new_description = 'New description'
  fill_in 'task_description', with: @new_description
  click_on 'task_submit'
end

Then /^the task should have new description$/ do
  task = Task.all.first
  task.description.should == @new_description
end

When /^I delete the task$/ do
  click_on "Delete"
end

Then /^there should be no tasks$/ do
  Task.all.should be_empty
end
