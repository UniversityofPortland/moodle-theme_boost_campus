@theme @theme_boost_campus @theme_boost_campus_advanced_settings
Feature: Configuring the theme_boost_campus plugin for the "Advanced settings" tab
  In order to use the features
  As admin
  I need to be able to configure the theme Boost Campus plugin

  Background:
    Given the following "users" exist:
      | username |
      | student1 |
      | teacher1 |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
    # This is needed that all settings for Boost Campus are processed and that
    # the footer will appear for all scenarios
    And I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "General settings" "link"
    And I set the field "id_s_theme_boost_campus_brandcolor" to "#7a99ac"
    And I press "Save changes"
    And I log out

  # This is not testable with Behat #
  Scenario: Add "Raw initial SCSS"
  Scenario: Add "Raw SCSS"
  Scenario: "Catch keyboard commands"

  Scenario: Set "Position of "Add a block" widget" to "At the bottom of the default block region"
    Given I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Advanced settings" "link"
    And I set the field "id_s_theme_boost_campus_addablockposition" to "positionblockregion"
    And I press "Save changes"
    And I log out
    When I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    Then I should see "Add a block" in the "#block-region-side-pre" "css_element"

  Scenario: Set "Position of "Add a block" widget" to "At the bottom of the nav drawer"
    Given I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Advanced settings" "link"
    And I set the field "id_s_theme_boost_campus_addablockposition" to "positionnavdrawer"
    And I press "Save changes"
    And I log out
    When I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    Then I should see "Add a block" in the "#nav-drawer" "css_element"
