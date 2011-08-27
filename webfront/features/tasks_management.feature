Feature: Task management
  As an admin
  I want to manage tasks / problem set

  Scenario: Create new task
    Given I am on the new admin task page
    When I fill in the task form
    Then the task should be created

  Scenario: Edit task
    Given one task exists
    And I am on the edit page of that task
    When I modify the task description
    Then the task should have new description

  Scenario: Delete task
    Given one task exists
    And I am on the admin tasks page
    When I delete the task
    Then there should be no tasks
