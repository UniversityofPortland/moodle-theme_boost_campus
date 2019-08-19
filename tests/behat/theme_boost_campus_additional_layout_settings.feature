@theme @theme_boost_campus @theme_boost_campus_additional_layout_settings
Feature: Configuring the theme_boost_campus plugin for the "Additional Layout Settings" tab
  In order to use the features
  As admin
  I need to be able to configure the theme Boost Campus plugin

  Background:
    Given the following "users" exist:
      | username |
      | teacher1 |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    # This is needed that all settings for Boost Campus are processed and that
    # the footer will appear for all scenarios
    And I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "General settings" "link"
    And I set the field "id_s_theme_boost_campus_brandcolor" to "#7a99ac"
    And I press "Save changes"
    And I log out

  @javascript @_file_upload
  Scenario: Add "Image area items"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Additional Layout Settings" "link"
    And I upload "theme/boost_campus/tests/fixtures/moodle_logo.jpg" file to "Image area items" filemanager
    And I press "Save changes"
    Then ".imagearea" "css_element" should exist

  # Dependent on setting "Image area items"
  @javascript @_file_upload
  Scenario: Add "Image area item links"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Additional Layout Settings" "link"
    And I upload "theme/boost_campus/tests/fixtures/moodle_logo.jpg" file to "Image area items" filemanager
    And I set the field "id_s_theme_boost_campus_imageareaitemslink" to "moodle_logo.jpg|http://moodle.org"
    And I press "Save changes"
    Then ".imagearea" "css_element" should exist
    And "//a[contains(@href, 'http://moodle.org')]" "xpath_element" should exist

  # Dependent on setting "Image area items"
  # This is not testable with behat.
  # Scenario: Set "Image area items maximal height"

  Scenario: Use Footnote setting
    Given the following config values are set as admin:
      | config   | value                                           | plugin             |
      | footnote | <a href="/login/logout.php">Logout Footnote</a> | theme_boost_campus |
    When I log in as "teacher1"
    Then I should see "Logout Footnote"
    And I click on "Logout Footnote" "link"
    Then I should see "Do you really want to log out?"

  Scenario: Enable "Dashboard menu item on top"
    Given the following config values are set as admin:
      | config               | value | plugin             |
      | defaulthomepageontop | yes   | theme_boost_campus |
    When I log in as "teacher1"
    Then "Dashboard" "link" should appear before "Site home" "link"
    When I am on "Course 1" course homepage
    Then "Dashboard" "link" should appear before "Site home" "link"

   # This is not testable with Behat
   # Scenario: Enable "Nav drawer full width on small screens"
