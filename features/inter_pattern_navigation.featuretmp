Feature: Navigation between patterns
  In order to maximise the inter-pattern relationships
  As a user
  I want to be presented with efficient navigation opportunities (?)

Background:
	Given a pattern system "a_system" with the name "a test system" and the author "bob le poulpe"
	And the locale is "en"
	
Scenario: Navigate to the parent pattern
	Given the following patterns for pattern system "a_system":
		|	name			|	author			|
		| a parent pattern	|	bob le poulpe	|
		| a child pattern	|	bob le poulpe	|
	And "a child pattern" is a child pattern of "a parent pattern"
	When I go to the show page of the pattern with name "a child pattern" from pattern system "a_system"
	Then I should see a breadcrumb linking to "a parent pattern"

Scenario: Navigate to child patterns (no graphic solution)
	Given the following patterns for pattern system "a_system":
		|	name				|	author			|
		| a parent pattern		|	bob le poulpe	|
		| first child pattern	|	bob le poulpe	|
		| second child pattern	|	bob le poulpe	|
	And "first child pattern" is a child pattern of "a parent pattern"
	And "second child pattern" is a child pattern of "a parent pattern"
	When I go to the show page of the pattern with name "a parent pattern" from pattern system "a_system"
	Then I should see a link to "first child pattern" in the "Use" relations
	And I should see a link to "second child pattern" in the "Use" relations
	
Scenario: Navigate to child patterns (with graphic solution)
	Given the following patterns for pattern system "a_system":
		|	name				|	author			|
		| a parent pattern		|	bob le poulpe	|
		| first child pattern	|	bob le poulpe	|
		| second child pattern	|	bob le poulpe	|
	And "first child pattern" is a child pattern of "a parent pattern"
	And "second child pattern" is a child pattern of "a parent pattern"
	And the process solution of "a parent pattern" is represented by the image "whatever.png"
	And "a parent pattern" has a map linking to "first child pattern"
	And "a parent pattern" has a map linking to "second child pattern"
	When I go to the show page of the pattern with name "a parent pattern" from pattern system "a_system"
	Then I should see a link to "first child pattern" in the "Use" relations
	And I should see a link to "second child pattern" in the "Use" relations
	And I should see a map linking to "first child pattern"
	And I should see a map linking to "second child pattern"

Scenario: Navigate to an alternative pattern
	Given the following patterns for pattern system "a_system":
		|	name					|	author			|
		| a parent pattern			|	bob le poulpe	|
		| a child pattern			|	bob le poulpe	|
		| alternative child pattern	|	bob le poulpe	|
	And "alternative child pattern" is an alternative to "a child pattern"
	When I go to the show page of the pattern with name "a child pattern" from pattern system "a_system"
	Then I should see a link to "alternative child pattern" in the "Forces" section
	
# Scenario: Create an alternative pattern
# 	Given the following patterns for pattern system "a_system":
# 		|	name					|	author			|
# 		| a parent pattern			|	bob le poulpe	|
# 		| a child pattern			|	bob le poulpe	|
# 	When I go to the show page of "a child pattern"
	# PENDING
	
Scenario: Navigate in the patterns list
	Given the following patterns for pattern system "a_system":
		|	name					|	author			|
		| a root pattern			|	bob le poulpe	|
		| a pattern 1				|	bob le poulpe	|
		| a pattern 2				|	bob le poulpe	|
		| a pattern 1.1				|	bob le poulpe	|
		| a pattern 1.2				|	bob le poulpe	|
		| a pattern 2.1				|	bob le poulpe	|
		| a pattern 2.2				|	bob le poulpe	|
	And "a pattern 1" is a child pattern of "a root pattern"
	And "a pattern 2" is a child pattern of "a root pattern"
	And "a pattern 1.1" is a child pattern of "a pattern 1"
	And "a pattern 1.2" is a child pattern of "a pattern 1"
	And "a pattern 2.1" is a child pattern of "a pattern 2"
	And "a pattern 2.2" is a child pattern of "a pattern 2"
	When I go to the show page of the pattern with name "a pattern 1.2" from pattern system "a_system"
	Then I should see a link to "a pattern 1" in the right column
	And I should see a link to "a pattern 1.1" in the right column
	And I should see a link to "a pattern 2" in the right column
	And I should see a link to "root pattern" in the right column
	But I should not see a link to "a pattern 2.1" in the right column
	But I should not see a link to "a pattern 2.2" in the right column
	