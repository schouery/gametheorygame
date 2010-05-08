Feature: Manage Symmetric Function Games
  In order to collect data about this kind of games
  the researcher
  wants to manage cards of symmetric function games
  
  @javascript
  Scenario: Register new Symmetric Function Game
    Given I am admin
    And I am on the new symmetric_function_game page
    When I fill in "Name" with "Polution Game For Four"
    And I fill in "Description" with "This is the Polution Game for two players. You will pay 3 + p if you choose not to polute and p if you choose to polute, where p is number of players polutting"
    And I fill in "Number of strategies" with "2"
    And I fill in "Number of players" with "4"
    # Mudar isso
    And I choose "symmetric_function_game_color_red"  
    # And I fill in "Label for stategy 1" with "Polute"
    # And I fill in "Label for stategy 2" with "Not Polute"
    And I fill in "Function" with "3 + s[1]"  
    And I press "Create"
    Then I should see "Polution Game For Four"
    And I should see "This is the Polution Game for two players. You will pay 3 + p if you choose not to polute and p if you choose to polute, where p is number of players polutting"
    And I should see "2"
    And I should see "4"
    And I should see "red"
    # And I should see "Polute"
    # And I should see "Not Polute"
    And I should see "3 + s[1]"
    