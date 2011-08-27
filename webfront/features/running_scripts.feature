Feature: running scripts

  @wip
  Scenario: Run simple script
    Given I am on the new submission page
    When I fill in "script_script" with "puts 'Hello world'"
    And I press "script_submit"
    Then I should see "Hello world"
