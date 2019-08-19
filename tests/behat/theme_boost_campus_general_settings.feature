@theme @theme_boost_campus @theme_boost_campus_general_settings
Feature: Configuring the theme_boost_campus plugin for the "General settings" tab
  In order to use the features
  As admin
  I need to be able to configure the theme Boost Campus plugin

  Background:
    # This is needed that all settings for Boost Campus are processed and that
    # the footer will appear for all scenarios
    And I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "General settings" "link"
    And I set the field "id_s_theme_boost_campus_brandcolor" to "#7a99ac"
    And I press "Save changes"
    And I log out

  # This is derivated from theme Boost and should be covered there with tests
  #  Scenario: Change "Theme preset"
  #  Scenario: Upload "Additional theme preset files"
  #  Scenario: Add "Background image"
  #  Scenario: Set "Brand colour"

  # This is not testable with behat
  #  Scenario: Set "Brand success colour"
  #  Scenario: Set "Brand info colour"
  #  Scenario: Set "Brand warning colour"
  #  Scenario: Set "Brand danger colour"

  @javascript @_file_upload
  Scenario: Add "Favicon"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "General settings" "link"
    And I upload "theme/boost_campus/tests/fixtures/favicon.ico" file to "Favicon" filemanager
    And I press "Save changes"
    Then "//head//link[contains(@href, 'favicon.ico')]" "xpath_element" should exist
