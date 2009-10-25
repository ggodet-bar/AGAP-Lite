Feature: Advanced User Navigation
  In order to clone a given pattern system or deploy a pattern system
  As a user
  I want to manage pattern system copies

Background:
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  And the locale is "en"

@clone
Scenario: Clone a pattern system
  Given the following patterns for pattern system "a_system":
	|	name					|	author			|
	| A process pattern			|	bob le poulpe	|
	| Another process pattern	|	bob le poulpe	|
  And I am on the edit page of the pattern with name "Another process pattern" from pattern system "a_system"
  When I select "A process pattern" from "Process context"
  And I press "Update"
  And I should see a link to pattern "A process pattern" from pattern system "a_system" in the pattern body
  And I clone the pattern system "a_system"
  And I fill in "Name" with "A new name"
  And I fill in "Author" with "Bob le poulpe"
  And I fill in "Short name" with "a_new_name"
  And I press "Clone system"
  Then I should see "Pattern System was cloned"
  And There should be 4 patterns in the records
  And the pattern system "a_new_name" should have 2 patterns
  And all the patterns of the new system should have "a_new_name" for a parent
  And There should be 2 pattern systems in the records
  And I am on the show page of the pattern with name "Another process pattern" from pattern system "a_new_name"
  And I should see a link to pattern "A process pattern" from pattern system "a_new_name" in the pattern body

@new_focus
Scenario: Do not clone the pattern system
  Given the following pattern for pattern system "a_system":
	|	name					|	author			|
	| A process pattern			|	bob le poulpe	|
  When I clone the pattern system "a_system"
  And I fill in "Short name" with "a_system"
  And I press "Clone system"
  Then I should not see "Pattern System was cloned"
  And I should see "Could not clone system."
  And There should be 1 pattern system in the records
  And There should be 1 pattern in the records

Scenario: Deploy a pattern system
  When I deploy the pattern system "a_system" to the distant site "site.example.com"
  Then I should see "Pattern System was deployed"