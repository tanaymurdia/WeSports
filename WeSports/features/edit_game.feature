Feature: edit a pickup sports game

  As a pickup-sports game creator
  So that I can edit the time, location, or number of players I'm looking for
  I want to be able to edit a game that I've created

  Background: games have been added to database

    Given the following games exist:
      | sport_name  | zipcode | slots_to_be_filled | game_start_time       | game_end_time        |
      | Spikeball   | 10027   | 4                  | 31-Oct-2021 12:00:00  | 31-Oct-2021 15:00:00 |
      | Basketball  | 10024   | 1                 | 1-Nov-2021 15:00:00  | 31-Oct-2021 15:30:00  |

    Given the following players exist:
      | username | email             | uid                   | provider      |
      | Jenny    | jxm033f@gmail.com | 118294165813028623643 | google_oauth2 |
      | Rando    | rando@gmail.com   | 423254832483294327100 | google_oauth2 |

    Given the following players created the following games:
      | sport_name  | email               |
      | Spikeball   | jxm033f@gmail.com   |

    Given I am logged in as "118294165813028623643"
    And I am on the details page for "Spikeball"

  Scenario: I navigate to the edit game page

    When I press "Edit"
    Then I should be on the edit page for "Spikeball"

  Scenario: I successfully edit the game

    When I am on the edit page for "Spikeball"
    When I fill in the following:
    | Sport Name            | Random Test Sport|
    | Total Slots Available | 6                |
    And I press "Update Game Info"
    Then I should see "Random Test Sport"
    And I should see "10027"
    And I should see "6"
    And I should see "Successfully updated game"

  Scenario: I attempt to edit a game with no name or zip code
    When I am on the edit page for "Spikeball"
    When I fill in the following:
      | Sport Name            |  |
      | Zip Code              | 10023            |
      | Total Slots Available | 6                |

    And I press "Update Game Info"
    Then I should be on the edit page for "Spikeball"
    And I should see "Error: Missing Zip Code or Sport Name Fields"

  Scenario: I attempt to make fewer slots available than are already taken
    When I add player with email "jxm033f@gmail.com" to game "Spikeball"
    When I add player with email "rando@gmail.com" to game "Spikeball"
    When I am on the edit page for "Spikeball"
    When I fill in the following:
      | Sport Name            |  Random Test Sport|
      | Zip Code              | 10023             |
      | Total Slots Available | 1                 |

    And I press "Update Game Info"
    Then I should be on the edit page for "Spikeball"
    And I should see "Error: More Slots Taken (2) than Available"