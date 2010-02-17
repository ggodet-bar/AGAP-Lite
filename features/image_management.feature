
Feature: Image management
  In order to add, delete and modify images in AGAP Lite
  I need to access the desired functionality

@ok
Scenario: Create a new pattern with an empty mappable image
    Given I have a pattern system
    And the pattern system formalism has an anonymous mappable image
    And I browse to the pattern systems list
    And I follow the "Show" link
    When I follow the "Add new pattern" link
    Then I should see 1 file field element
    And I should see the text "No element was specified for classification field "Participants""
    But I should not see the text "Add a map"

@ok
Scenario: Create a new pattern with an existing mappable image
    Given I have a pattern system named "My pattern system"
    And the pattern system formalism has a mappable image named "The image"
    And I browse to the show page of the pattern system "My pattern system"
    When I follow the "Add new pattern" link
    And I upload a file with valid data for the image named "The image"
    Then I should wait 2 seconds
    And I should see the text "Add a map"
    And I should see a valid image

@ok
Scenario: Edit a pattern with an empty mappable image
    Given I have a pattern system
    And the pattern system formalism has an anonymous mappable image
    And I have a pattern named "My pattern"
    When I browse to the edit page of the pattern named "My pattern"
    Then I should see 1 file field element
    And I should not see the text "Add a map"

@ok
Scenario: Edit a pattern with an existing mappable image
    Given I have a pattern system
    And the pattern system formalism has a mappable image named "The image"
    And I have a pattern named "My pattern"
    And I have a mappable image attached to the pattern "My pattern" for the field "The image"
    When I browse to the edit page of the pattern named "My pattern"
    Then I should wait 1 seconds
    Then I should see 0 file field element
    And I should see the text "Add a map"
    And I should see 1 dl element
    And I should see a valid image

@ok
Scenario: Delete an existing image
    Given I have a pattern system
    And the pattern system formalism has a mappable image named "The image"
    And I have a pattern named "My pattern"
    And I have a mappable image attached to the pattern "My pattern" for the field "The image"
    When I browse to the edit page of the pattern named "My pattern"
    And I click on the "delete image" image
    Then I should see 1 file field element
    But I should not see the text "Add a map"
    And I should see 0 dl element

@ok
Scenario: Add an image then delete it
    Given I have a pattern system named "My pattern system"
    And the pattern system formalism has a mappable image named "The image"
    And I have a pattern named "My pattern"
    When I browse to the edit page of the pattern named "My pattern"
    And I upload a file with valid data for the image named "The image"
    And I should wait 1 second
    And I click on the "delete image" image
    Then I should see 1 file field element
    But I should not see the text "Add a map"
    And I should see 0 dl element

@ok
Scenario: Add an image then delete it then add it again
    Given I have a pattern system named "My pattern system"
    And the pattern system formalism has a mappable image named "The image"
    And I have a pattern named "My pattern"
    When I browse to the edit page of the pattern named "My pattern"
    And I upload a file with valid data for the image named "The image"
    And I should wait 1 second
    And I click on the "delete image" image
    And I upload a file with valid data for the image named "The image"
    And I should wait 1 second
    Then I should see 0 file field element
    And I should see the text "Add a map"
    And I should see 1 dl element
    And I should see a valid image

@ok
Scenario: Add an image then update the existing pattern
    Given I have a pattern system named "My pattern system"
    And the pattern system formalism has a mappable image named "The image"
    And I have a pattern named "My pattern"
    When I browse to the edit page of the pattern named "My pattern"
    And I upload a file with valid data for the image named "The image"
    And I should wait 3 second
    And I press the "Update" button
    Then I should see the text "Pattern was successfully updated"
    And I should see the text "The image"
    And I should see 1 dl element
    And I should see a valid image
