Feature: Submissions history
  As a registered user
  I should be able to see history of my submissions

  Scenario: List history of submissions
    Given I am signed in user
    And one task exists
    And I have submitted three solutions
    When I go to the submissions page
    Then I should see three submissions
