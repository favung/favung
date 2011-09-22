Feature: Solution submission
  As a registered user
  I should be able to submit solution to the problem

  Scenario: Submit solution for existing problem
    Given I am signed in user
    And one task exists
    When I go to the new submission page
    And I submit the solution
    Then I should see "Your solution has been submitted successfuly"
    And the solution should be send to the queue
