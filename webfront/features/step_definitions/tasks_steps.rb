Then /^I should see that task$/ do
  page.should have_content @task.name
end

When /^I click on this task$/ do
  click_on @task.name
end

Then /^I should see the description of that task$/ do
  page.should have_content @task.description
end
