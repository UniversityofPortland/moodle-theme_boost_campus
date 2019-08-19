@theme @theme_boost_campus @theme_boost_campus_footer_layout_settings
Feature: Configuring the theme_boost_campus plugin for the "Footer Layout Settings" tab
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

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: Setting "Footer blocks" to "One block columns in footer"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "id_s_theme_boost_campus_footerblocks" to "1columns"
    And I click on "Advanced settings" "link"
    And I set the field "id_s_theme_boost_campus_addablockposition" to "positionnavdrawer"
    And I press "Save changes"
    And I follow "Dashboard" in the user menu
    When I press "Customise this page"
    And I add the "Latest announcements" block
    And I configure the "Latest announcements" block
    And I set the following fields to these values:
      | id_bui_region | footer-left |
    And I press "Save changes"
    Then I should see "Latest announcements" in the "#block-region-footer-left" "css_element"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: Setting "Footer blocks" to "Two block columns in footer"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "id_s_theme_boost_campus_footerblocks" to "2columns"
    And I click on "Advanced settings" "link"
    And I set the field "id_s_theme_boost_campus_addablockposition" to "positionnavdrawer"
    And I press "Save changes"
    And I follow "Dashboard" in the user menu
    When I press "Customise this page"
    And I add the "Latest announcements" block
    And I configure the "Latest announcements" block
    And I set the following fields to these values:
      | id_bui_region | footer-left |
    And I press "Save changes"
    And I add the "Comments" block
    And I configure the "Comments" block
    And I set the following fields to these values:
      | id_bui_region | footer-right |
    And I press "Save changes"
    Then I should see "Latest announcements" in the "#block-region-footer-left" "css_element"
    And I should see "Comments" in the "#block-region-footer-right" "css_element"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: Setting "Footer blocks" to "Three block columns in footer"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "id_s_theme_boost_campus_footerblocks" to "3columns"
    And I click on "Advanced settings" "link"
    And I set the field "id_s_theme_boost_campus_addablockposition" to "positionnavdrawer"
    And I press "Save changes"
    And I follow "Dashboard" in the user menu
    When I press "Customise this page"
    And I add the "Latest announcements" block
    And I configure the "Latest announcements" block
    And I set the following fields to these values:
      | id_bui_region | footer-left |
    And I press "Save changes"
    And I add the "Comments" block
    And I configure the "Comments" block
    And I set the following fields to these values:
      | id_bui_region | footer-middle |
    And I press "Save changes"
    And I add the "Tags" block
    And I configure the "Tags" block
    And I set the following fields to these values:
      | id_bui_region | footer-right |
    And I press "Save changes"
    Then I should see "Latest announcements" in the "#block-region-footer-left" "css_element"
    And I should see "Comments" in the "#block-region-footer-middle" "css_element"
    And I should see "Tags" in the "#block-region-footer-right" "css_element"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: "Hide link to the Moodle docs"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "s_theme_boost_campus_footerhidehelplink" to "1"
    And I press "Save changes"
    And I log out
    When I log in as "teacher 1"
    Then I should not see "Moodle Docs for this page" in the "page-footer" "region"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: "Hide login information"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "s_theme_boost_campus_footerhidelogininfo" to "1"
    And I press "Save changes"
    Then I should not see "You are logged in as Admin User" in the "page-footer" "region"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: "Hide link to the webpage start"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "s_theme_boost_campus_footerhidehomelink" to "1"
    And I press "Save changes"
    Then I should not see "Home" in the "page-footer" "region"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: "Hide link to reset the user tour"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "s_theme_boost_campus_footerhideusertourslink" to "1"
    And I press "Save changes"
    And I log out
    When I log in as "teacher 1"
    And I am on site homepage
    Then I should not see "Reset user tour on this page" in the "page-footer" "region"

  # This scenario needs full browser support and therefore the @javascript.
  @javascript
  Scenario: "Hiding the footer on the login page"
    When I log in as "admin"
    And I navigate to "Appearance > Boost Campus" in site administration
    And I click on "Footer Layout Settings" "link"
    And I set the field "s_theme_boost_campus_hidefooteronloginpage" to "1"
    And I press "Save changes"
    And I log out
    And I click on "Log in" "link"
    Then I should not see "You are not logged in."
