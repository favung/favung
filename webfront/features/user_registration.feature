Feature: User registration
  As a user
  I want to create an account and sign in

  Scenario: Register new user
    Given I am on the home page
    When I follow to the sign up page
    And I fill in sign up form
    Then I should be signed in

  Scenario: Registered user can sign in
    Given I am registered user
    And I am on the home page
    When I follow the sign in page
    And I fill in sign in form
    Then I should be signed in

  Scenario: Signed in user can sign out
    Given I am signed in user
    When I click on sign out link
    Then I should be signed out
