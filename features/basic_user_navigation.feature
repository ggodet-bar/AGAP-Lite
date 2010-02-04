
Feature: Basic User Navigation
  In order to use the basic features of the system
  As a pattern system creator
  I want to manage and navigate the pattern systems

Background:
#  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  Given the locale is "en"
#  And I am on the homepage

Scenario: Blank list of pattern systems
  Given I am on the homepage
  When I follow "enter"
  Then I should see "New pattern system"

Scenario: Look at metamodels
  Given I am on the pattern systems list
  When I follow "New pattern system"
  Then I should see "Author"
  And I should see "Name"
  And I should see "System metamodel"
  And I should see "Creation of a new pattern system (step 1/2)"

Scenario: Create a pattern system with one pattern type
  Given I am on the pattern systems list
  And I follow "New pattern system"
  When I fill in "Author" with "Bob le poulpe"
  And I fill in "Name" with "A test system"
  And I select "Gamma formalism" from "pattern_system_system_formalism_id"
  And I press "Next"
  Then I should see "Patternsystem was successfully created"
  And I should see "Creation of a new pattern system (step 2/2)"

Scenario: Create a pattern system with several pattern types
  Given I am on the pattern systems list
  And I follow "New pattern system"
  When I fill in "Author" with "Bob le poulpe"
  And I fill in "Name" with "A test system"
  And I select "P-SIGMA formalism" from "pattern_system_system_formalism_id"
  And I press "Next"
  Then I should see "Patternsystem was successfully created"

Scenario: Edit an existing pattern system
  Given I have 1 pattern system
  And I am on the pattern systems list
  When I follow "Edit"
  Then I should see "Editing pattern system"

#Scenario: Visit a pattern system
#  When I go to the pattern system "a_system"
#  Then I should see "a test system"
#  And I should see "bob le poulpe"
#
#Scenario: Create two pattern systems with the same short names
#  When I create a pattern system with the short name "a_system" with the name "a test system 2" and the author "bob le poulpe 2"
#  Then I should see "Short name has already been taken"
#
#Scenario: Add an image to the pattern definition
#  Given the following pattern for pattern system "a_system":
#	|	name			|	author			|
#	| a test pattern	|	bob le poulpe	|
#  And I am on the edit page of the pattern with name "a test pattern" from pattern system "a_system"
#  And I attach the file at "/Users/godetg/Documents/RadAGAP/public/images/common_images/loading.gif" to "Upload a file"
#  And I press "Update"
#  Then I should see "Processpattern was successfully updated."
#  And I should see an image
#
#Scenario: Create a new pattern
#  Given I am on the page of the pattern system "a test system"
#  When I follow "Add new pattern"
#  And I fill in "Name" with "Un patron de charcuterie"
#  And I fill in "Author(s)" with "Roger le boucher"
#  And I press "Create"
#  Then I should see "Processpattern was successfully created."
#  And I should see "Roger le boucher"
#  And I should see "Un patron de charcuterie"
##  And There should be 1 pattern in the records
#
#Scenario: Modify a text field and update the pattern
#  Given the following pattern for pattern system "a_system":
#  	|	name			|	author			|
#  	| a test pattern	|	bob le poulpe	|
#  And I am on the edit page of the pattern with name "a test pattern" from pattern system "a_system"
#  When I fill in "Name" with "Another pattern"
#  And I fill in "Problem" with "A problem definition"
#  And I press "Update"
#  Then I should see "Processpattern was successfully updated."
#  And I should see "Another pattern"
#  And I should see "A problem definition" 
#  But I should not see "a test pattern"
#
#
#@focus
#Scenario: Add a map to the process solution
#  Given the following patterns for pattern system "a_system":
#	|	name			|	author			|
#	| a test pattern	|	bob le poulpe	|
#	| another pattern	|	bob le poulpe	|
#  And I add an image "whatever.png" associated to the pattern with name "a test pattern"
#  And I am on the edit page of the pattern with name "a test pattern" from pattern system "a_system"
#  When I add a map with the coordinates "10, 40, 100, 200" and the target pattern "another pattern" to the pattern "a test pattern"
#  And I add a map with the coordinates "40, 60, 400, 800" and the target pattern "a test pattern" to the pattern "a test pattern"
#  And I press "Update"
#  Then I should see "Processpattern was successfully updated."
#  And I should see a "dd" tag
#  And There should be 2 maps in the records
#  And There should be 2 patterns in the records
#  And I should see an image
