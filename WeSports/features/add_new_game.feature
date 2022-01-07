Feature: create a new pickup sports game

  As a pickup-sports player
  So that I can create games for other people to join
  I want to be able to add a game that other players can find

Background:

  Given the following players exist:
  | username | email             | uid                   | provider      |
  | Jenny    | jxm033f@gmail.com | 118294165813028623643 | google_oauth2 |

  Given I am logged in as "118294165813028623643"
  Given I am on the WeSports home page

Scenario: I navigate to the add new game page

  When I press "Add new game"
  Then I should be on the new game page

Scenario: I create a new game

  When I am on the new game page
  When I fill in the following:
    | Sport Name            | Random Test Sport|
    | Zip Code              | 10027            |
    | Total Slots Available | 10               |
  And I press "Save Changes"
  Then I should see "Random Test Sport"
  And I should see "Successfully created"

Scenario: I attempt to create a game with no name or zip code
  When I am on the new game page
  When I fill in the following:
    | Sport Name            |  |
    | Zip Code              | 10027            |
    | Total Slots Available | 10               |
  And I press "Save Changes"
  Then I should be on the new game page
  And I should see "Error: Missing Zip Code or Sport Name Fields"

Scenario: I attempt to create a game with no slots available
  When I am on the new game page
  When I fill in the following:
    | Sport Name            |  Random Test Sport|
    | Zip Code              | 10027             |
    | Total Slots Available |                   |
  And I press "Save Changes"
  Then I should be on the new game page
  And I should see "Error: Total Slots Available not valid"