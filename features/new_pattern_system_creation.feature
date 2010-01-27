Feature: Pattern System Creation
  In order to create a brand new pattern system
  As a standard user
  I want to go through the necessary steps for creating the pattern system

Scenario: Choose to create a new pattern system
  Given I am on the homepage
  When I click 'New pattern system'
  Then I should see 'Select a pattern metamodel'
  And I should see a drop-down list of pattern metamodels

Scenario: Browse through the existing metamodels
  Given I have chosen to create a new pattern system
  When I select 'Gamma metamodel'
  Then I should see a description of the Gamma metamodel

Scenario: Select an existing metamodel
  Given I have chosen to create a new pattern system
  When I select 'Gamma metamodel'
  And I click 'Accept'
  Then I should see a new page with the properties of the pattern system

Scenario: Define basic properties for the new pattern system
  Given I have created a new pattern system, based on the Gamma metamodel
  When I fill some fields
  And I click 'Accept'
  Then I should see a list of pattern systems
  And I should see my new pattern system

# For the rest, which should be getting back to the usual AGAP Lite usage
