Feature: User features

  Scenario: Signing up as a new user
    Given I am on the 'Sign-Up' page
    And I create my user
    Then I should be signed up

  Scenario: As a logged in user I create a report
    Given I am logged in
    Then I can create a report

  Scenario: Edit a report
    Given I am logged in
    And I have authored a report
    Then I can edit that report

