When /^I follow to the sign up page$/ do
  click_on "Sign up"
end

When /^I fill in sign up form$/ do
  fill_in 'user_email', with: 'foo@example.org'
  fill_in 'user_password', with: 'secret'
  fill_in 'user_password_confirmation', with: 'secret'
  click_on 'user_submit'
end

Then /^I should be signed in$/ do
  page.should have_content('Logged in as')
  page.should have_content('Log out')
end

Given /^I am registered user$/ do
  @user = Fabricate(:user)
end

When /^I follow the sign in page$/ do
  click_on 'log in'
end

When /^I fill in sign in form$/ do
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  click_on 'user_submit'
end

Given /^I am signed in user$/ do
  Given 'I am registered user'
  And 'I am on the home page'
  And 'I follow the sign in page'
  And 'I fill in sign in form'
end

When /^I click on sign out link$/ do
  click_on 'Log out'
end

Then /^I should be signed out$/ do
  page.should_not have_content('Signed in as')
  page.should_not have_content('Sign out')
  page.should have_content('log in')
  page.should have_content('Sign up')
end

Given /^I am signed in as admin$/ do
  @user = Fabricate(:user, role: 'admin')
  And 'I am on the home page'
  And 'I follow the sign in page'
  And 'I fill in sign in form'
end
