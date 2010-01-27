Feature: Formalism management
  In order to manage the formalisms
  As a knowledgeable user
  I want to be able to create, modify and destroy pattern formalisms


Scenario: Get to the list of formalisms
  Given I am on the homepage
  When I click 'Manage formalisms'
  Then I should see a list of formalisms

Scenario: Create a new system formalism
  Given I am on the list of formalisms
  When I click 'Create'
  Then I should see a bunch of fields for creating a new formalism

Scenario: Create a new pattern formalism
  Given I am editing a system formalism
  When I click 'Add a new pattern formalism'
  Then I should see a bunch of fields for creating a new pattern formalism

Scenario: Select a main pattern formalism
  Given I am editing a system formalism
  And I have already created a pattern formalism named 'Pattern Type A'
  And I have already created a pattern formalism named 'Pattern Type B"
  When I select "Pattern Type B" as main pattern
  Then I should see "Pattern Type B is now the main pattern of your system"
