
Feature: User Navigation
  In order to clone a given pattern system
  As a user
  I want to manage pattern system copies

Background:
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  And the locale is "en"

@clone
Scenario: Clone a pattern system
  When I add a pattern "A process pattern" with author "Bob le poulpe" to the pattern system "a_system"
  And I clone the pattern system "a_system"
  And I fill in "Name" with "A new name"
  And I fill in "Author" with "Bob le poulpe"
  And I fill in "Short name" with "a_new_name"
  And I press "Clone system"
  Then I should see "Pattern System was cloned"
  And the pattern system "a_new_name" should have 1 pattern
  And all the patterns of the new system should have "a_new_name" for a parent
  And There should be 2 pattern systems in the records

@new_focus
Scenario: Do not clone the pattern system
  When I clone the pattern system "a_system"
  And I fill in "Short name" with "a_system"
  And I press "Clone system"
  Then I should not see "Pattern System was cloned"
  And I should see "Name has already been taken"
  And I should see "Short name has already been taken"
  And There should be 1 pattern system in the records

Scenario: Deploy a pattern system
  When I deploy the pattern system "a_system" to the distant site "site.example.com"
  Then I should see "Pattern System was deployed"

Scenario: Visit a pattern system
  When I go to the pattern system "a_system"
  Then I should see "a test system"
  And I should see "bob le poulpe"

Scenario: Create two pattern systems with the same short names
  When I create a pattern system with the short name "a_system" with the name "a test system 2" and the author "bob le poulpe 2"
  Then I should see "Short name has already been taken"

Scenario: Add an image to the pattern definition
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And I am on the edit page of the pattern with name "a test pattern"
  When I attach the file at "/Users/godetg/Documents/RadAGAP/public/images/loading.gif" to "Upload a file"
  And I press "Update"
  Then I should see "Processpattern was successfully updated." 

Scenario: Create a new pattern
  Given I am on the page of the pattern system "a test system"
  When I follow "Add new pattern"
  And I fill in "Name" with "Un patron de charcuterie"
  And I fill in "Author(s)" with "Roger le boucher"
  And I press "Create"
  Then I should see "Processpattern was successfully created."
  And I should see "Roger le boucher"
  And I should see "Un patron de charcuterie"
  And There should be 1 pattern in the records

Scenario: Modify a text field and update the pattern
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And I am on the edit page of the pattern with name "a test pattern"
  When I fill in "Name" with "Another pattern"
  And I fill in "Problem" with "A problem definition"
  And I press "Update"
  Then I should see "Processpattern was successfully updated."
  And I should see "Another pattern"
  And I should see "A problem definition" 
  And I should not see "a test pattern"


@focus
Scenario: Add a map to the process solution
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And a pattern with the name "another pattern" and the author "bob le poulpe"
  And an image "whatever.png" associated to the pattern with name "a test pattern"
  And I am on the edit page of the pattern with name "a test pattern"
  And There should be 2 patterns in the records
  When I add a map with the coordinates "10, 40, 100, 200" and the target pattern "another pattern" to the pattern "a test pattern"
  And I add a map with the coordinates "40, 60, 400, 800" and the target pattern "a test pattern" to the pattern "a test pattern"
  And I press "Update"
  Then I should see "Processpattern was successfully updated."
  And I should see a "dd" tag
  And There should be 2 maps in the records
