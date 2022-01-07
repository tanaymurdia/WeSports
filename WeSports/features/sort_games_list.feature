Feature: Sort table by a specific name, zip or start date
  As an user, I would like to filter the table
  by a specific name, zip or start date.

  Background: movies have been added to database

    Given the following games exist:
      | sport_name  | zipcode | slots_to_be_filled | game_start_time       | game_end_time |
      | Spikeball   | 10027   | 4                  | 31-Oct-2021 15:03:00  |               |
      | Basketball  | 10024   | 10                 | 31-Oct-2021 15:03:00  |               |
      | basketball  | 10025   | 10                 | 03-Nov-2021 10:00:00  |               |
      | Football    | 10030   | 22                 | 03-Nov-2021 16:00:00  |               |
      | soccer      | 10050   | 10                 | 03-Nov-2021 12:00:00  |               |

    Given the following players exist:
      | username | email             | uid                   | provider      |
      | Jenny    | jxm033f@gmail.com | 118294165813028623643 | google_oauth2 |

    Given I am logged in as "118294165813028623643"
    And  I am on the WeSports home page
    Then 5 seed games should exist

  Scenario: sort sport_games alphabetically
    When I follow "Sport Name"
    Then I should see "Basketball" before "Spikeball"
    Then I should see "Football" before "soccer"

  Scenario: sort games in increasing order based on start time
    When I follow "Start Time"
    Then I should see "Basketball" before "basketball"
    Then I should see "soccer" before "Football"
