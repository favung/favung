Feature: running scripts

  Scenario: Run simple script
  Given I am on the submit script page
  When I fill in "script_script" with "puts 'Hello world'"
  And I press "script_submit"
  Then I should see "Hello world"
