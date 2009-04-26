Feature: User Navigation
  In order to clone a given pattern system
  As a user
  I want to manage pattern system copies

Scenario: Clone a pattern system
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  When I clone the pattern system "a_system"
  Then I should be prompted to give a new short name "a_system_2" to the copied pattern system
  Then I should see "Pattern System was cloned"
  And  I should see 2 pattern systems

Scenario: Deploy a pattern system
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  When I deploy the pattern system "a_system" to the distant site "site.example.com"
  Then I should see "Pattern System was deployed" if the deployment was successful

Scenario: Visit a pattern system
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  When I navigate to the pattern system "a_system"
  Then I should see the name "a test system" of the pattern system and its author "bob le poulpe"

Scenario: Create two pattern systems with the same short names
  Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
  When I create a pattern system with the short name "a_system" with the name "a test system 2" and the author "bob le poulpe 2"
  Then I should see "Short name n'est pas disponible"

Scenario: Add an image to the pattern definition
  Given a pattern with the name "a test pattern" and the author "bob le poulpe"
  And I am on the edit page of the pattern with name "a test pattern"
  When I attach the file at "/Users/godetg/Documents/RadAGAP/public/images/loading.gif" to "mappable_image[uploaded_data]"
  And I press "Actualiser"
  Then I should see "/images/an_image.png"