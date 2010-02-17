
Feature: Basic User Navigation
  In order to use the basic features of the system
  As a pattern system creator
  I want to manage and navigate the pattern systems

Background:
  Given the locale is "en"

@ok
Scenario: Blank list of pattern systems
  Given I am on the homepage
  When I follow "enter"
  Then I should see "New pattern system"

@ok
Scenario: Look at metamodels
  Given I have the following system formalism names:
  	| name      |
	| Fake name |
  And I am on the pattern systems list
  When I follow "New pattern system"
  Then I should see "Author"
  And I should see "Name"
  And I should see "System metamodel"
  And I should see "Creation of a new pattern system (step 1/2)"

@ok
Scenario: Create a pattern system with one pattern type
  Given I have the following system formalism names:
  	| name       |
	| First form |
  And I am on the pattern systems list
  When I follow "New pattern system"
  And I fill in "Author" with "Bob le poulpe"
  And I fill in "Name" with "A test system"
  And I select "First form" from "pattern_system[system_formalism_id]"
  And I press "Next"
  Then I should see "Patternsystem was successfully created"
  And I should see "Creation of a new pattern system (step 2/2)"

@ok
Scenario: Create a pattern system with several pattern types
  Given I have the following system formalism names:
  	| name        |
	| First form  |
	| Second form |
  Given I am on the pattern systems list
  And I follow "New pattern system"
  When I fill in "Author" with "Bob le poulpe"
  And I fill in "Name" with "A test system"
  And I select "Second form" from "pattern_system[system_formalism_id]"
  And I press "Next"
  Then I should see "Patternsystem was successfully created"

@ok
Scenario: Edit an existing pattern system
  Given I have 1 pattern system
  And I am on the pattern systems list
  When I follow "Edit"
  Then I should see "Editing pattern system"

