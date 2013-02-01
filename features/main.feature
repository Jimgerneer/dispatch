Feature: Main page functionality

  Background:
    Given The db is seeded
    And I am signed in

    Scenario: Viewing index
      Given I file a report against a player
      Then I should see that report

    Scenario: Creating Claim
      Given I am on the case page
      And I click the "Claim Pearl" link
      And I fill out a claim
      Then a claim should be filed

    Scenario: Closing Report with claim
      Given a user has claimed capture of my perp
      And I close my report
      And I reward them a point
      Then they should be on the leaderboard
