Feature: Tasks
  As a user
  I want to see all available tasks

  Scenario: Show tasks
    Given one task exists
    When I go to the tasks page
    Then I should see that task

  Scenario: Show task description
    Given one task exists
    When I go to the tasks page
    And I click on this task
    Then I should see the description of that task
