Feature: Highlighting words to avoid

@javascript
Scenario: Should see the count of words to avoid (3 used: growth, facilitate, progress)
  Given I am a writer
  And a draft news article "Q2 Plan" with summary "Foster growth and facilitate progress" exists
  When I am on the edit page for news article "Q2 Plan"
  Then I should see the text "Ensure that usage of the 3 highlighted words conforms with the style guide."
