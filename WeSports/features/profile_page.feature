Feature: Profile Page for a user

  As an user
  So that there is one location with all relevant information
  I want to see a page with all the games I've joined and created
  I want to be able to see other people's profile pages

  Background: games have been added to database

    Given the following games exist:
      | sport_name  | zipcode | slots_to_be_filled | game_start_time       | game_end_time |
      | Spikeball   | 10027   | 4                  | 31-Oct-2021 15:03:00  |               |
      | Basketball  | 10024   | 10                 | 31-Oct-2021 15:03:00  |               |

    Given the following players exist:
      | username | email             | uid                   | provider      |
      | Jenny    | jxm033f@gmail.com | 118294165813028623643 | google_oauth2 |
      | Sam      | sam@gmail.com     | 478954943904382256666 | google_oauth2 |

    Given the following players created the following games:
      | sport_name  | email               |
      | Spikeball   | jxm033f@gmail.com   |
      | Basketball  | jxm033f@gmail.com   |

    Given the following players joined the following games:
      | sport_name   | email               |
      | Basketball   | jxm033f@gmail.com   |
      | Basketball   | sam@gmail.com       |

    Given I am logged in as "118294165813028623643"
    And I am on the WeSports home page

  Scenario: I see the games created and joined on my profile page
    When I press "Profile Page"
    Then I should be on the profile page for "Jenny"
    And I should see "Basketball" before "Games Created:"
    And I should see "Spikeball" before "Games Created:"
    And I should see "Games Created:" before "Spikeball"

  Scenario: I can navigate to another-player's profile page:
    When I am on the details page for "Basketball"
    When I follow "Sam"
    Then I should be on the profile page for "Sam"
    And I should see "Basketball" before "Games Created:"


