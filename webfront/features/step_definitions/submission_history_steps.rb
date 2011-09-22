Given /^I have submitted three solutions$/ do
  3.times do
    visit new_submission_path
    fill_in 'submission_source', with: 'Solution'
    click_button 'Submit'
  end
end

Then /^I should see three submissions$/ do
  within('.submissions') do
    all('.submission').should have(3).elements
  end
end
