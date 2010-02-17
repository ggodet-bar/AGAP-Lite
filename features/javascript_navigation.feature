
Feature: Javascript Navigation
  In order to use the full functionality of AGAP Lite
  I need to use JavaScript assisted navigation

@ok
Scenario: Add classification elements
    Given I have a pattern system
    And the pattern system formalism has an anonymous simple classification
    And I browse to the pattern systems list
    When I follow the "Edit" link
    And I follow the "add" link
    And I fill the 2nd text field with "A classification element"
    And I press the "Update" button
    Then I should see the text "Patternsystem was successfully updated"
    And I should see the text "A classification element"

@ok
Scenario: Create a new pattern with no participant
    Given I have a pattern system
    And I browse to the pattern systems list
    And I follow the "Show" link
    When I follow the "Add new pattern" link
    Then I should see 2 text field elements
    And I should see the text "No element was specified for classification field "Participants""

@ok
Scenario: Create 2 participants
    Given I have a pattern system
    And I browse to the pattern systems list
    When I follow the "Edit" link
    And I follow the "add" link
    And I fill the 2nd text field with "First participant"
    And I follow the "add" link
    And I fill the 4th text field with "Second participant"
    And I press the "Update" button
    Then I should see the text "First participant"
    And I should see the text "Second participant"

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

@ok
Scenario: Create a new pattern with an empty multi classification
    Given I have a pattern system
    And the pattern system formalism has a multi classification named "A classification"
    And I browse to the pattern systems list
    When I follow the "Show" link
    And I follow the "Add new pattern" link
    Then I should see the text "No element was specified for classification field "A classification""

@ok
Scenario: Create a new pattern with a multi classification that has a few classification elements
    Given I have a pattern system
    And the pattern system formalism has a multi classification named "My classification"
    And the pattern system has the following classification elements for the field named "My classification":
    	| name                   |
	| First classif element  |
	| Second classif element |
	| Third classif element  |
	| Fourth classif element |
    And I browse to the pattern systems list
    When I follow the "Show" link
    And I follow the "Add new pattern" link
    Then I should not see the text "No element was specified for classification field "My classification""
    But I should see 1 select list element
    And the select list for field "My classification" should include the following options:
	| name                   | selected | disabled |
	| First classif element  | false    | false    |
	| Second classif element | false    | false    |
	| Third classif element  | false    | false    |
	| Fourth classif element | false    | false    |
    
