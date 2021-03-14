Feature: create movies list
  
  As a movie buff
  So that I can create movie list that I want
  I want to create movie with title
  
Scenario: create a movie with title
  When I go to the new page
  And I fill in "Title" with "Star Wars"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Star Wars was successfully created."
  
Scenario: cancel creating a movie with title
  When I go to the new page
  And I fill in "Title" with "Star Wars"
  And I follow "Cancel"
  Then I should be on the home page
  And I should not see "Star Wars"