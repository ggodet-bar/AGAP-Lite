Feature: User Navigation
  In order to clone a given pattern system
  As a user
  I want to manage pattern system copies

Background:
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"

Scenario: Clone a pattern system
  When I clone the pattern system "a_system"
  Then I should be prompted to give a new short name "a_system_2" to the copied pattern system
  Then I should see "Pattern System was cloned"
  And There should be 2 pattern systems in the records

Scenario: Deploy a pattern system
  When I deploy the pattern system "a_system" to the distant site "site.example.com"
  Then I should see "Pattern System was deployed"

Scenario: Visit a pattern system
  When I go to the pattern system "a_system"
  Then I should see "a test system"
  And I should see "bob le poulpe"

Scenario: Create two pattern systems with the same short names
  When I create a pattern system with the short name "a_system" with the name "a test system 2" and the author "bob le poulpe 2"
  Then I should see "Short name n'est pas disponible"

Scenario: Add an image to the pattern definition
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And I am on the edit page of the pattern with name "a test pattern"
  When I attach the file at "/Users/godetg/Documents/RadAGAP/public/images/loading.gif" to "Charger un fichier"
  And I press "Actualiser"
  Then I should see "Le patron a été actualisé." 

Scenario: Create a new pattern
  Given I am on the page of the pattern system "a test system"
  When I follow "Ajouter un nouveau patron"
  And I fill in "Nom" with "Un patron de charcuterie"
  And I fill in "Auteur(s)" with "Roger le boucher"
  And I press "Créer"
  Then I should see "Le patron a été créé avec succès."
  And I should see "Roger le boucher"
  And I should see "Un patron de charcuterie"
  And There should be 1 pattern in the records

@focus
Scenario: Modify a text field and update the pattern
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And I am on the edit page of the pattern with name "a test pattern"
  When I fill in "Nom" with "Another pattern"
  And I fill in "Problème" with "A problem definition"
  And I press "Actualiser"
  Then I should see "Le patron a été actualisé."
  And I should see "Another pattern"
  And I should see "A problem definition" 
  And I should not see "a test pattern"

