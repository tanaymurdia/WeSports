Feature: delete game from games list

  As an interested user
  I want to see games that will actually occur

Background: games have been added to database

  Given the following games exist:
    | sport_name  | zipcode | slots_to_be_filled | game_start_time       | game_end_time |
    | Spikeball   | 10027   | 4                  | 31-Oct-2021 15:03:00  |               |
    | Basketball  | 10024   | 10                 | 31-Oct-2021 15:03:00  |               |

  Given the following players exist:
    | username | email             | uid                   | provider      |
    | Jenny    | jxm033f@gmail.com | 118294165813028623643 | google_oauth2 |

  Given the following players created the following games:
    | sport_name  | email               |
    | Spikeball   | jxm033f@gmail.com   |

  Given I am logged in as "118294165813028623643"
  And  I am on the WeSports home page
  Then 2 seed games should exist

Scenario: delete game from games
  Given I am on the details page for "Spikeball"
  And  I press "Delete"
  Then 1 seed games should exist