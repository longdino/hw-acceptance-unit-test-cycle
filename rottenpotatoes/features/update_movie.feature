Feature: update a movie from the movie list
  
  As a movie buff
  So that I can update a movie from the movie list that is already created
  I want to update a movie with title
  
Background: movies in database
  
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: update a movie with title
  Given I am on the edit page for "Star Wars"
  When I fill in "Title" with "Starrr Warrrs"
  And I press "Update Movie Info"
  Then I should see "Starrr Warrrs was successfully updated."
  And I should see "Starrr Warrrs"

Scenario: cancel updating a movie with title
  Given I am on the edit page for "Star Wars"
  And I fill in "Title" with "Star Wars 2"
  And I follow "Cancel"
  Then I should be on the home page
  And I should see "Star Wars"
  And I should not see "Star Wars 2"