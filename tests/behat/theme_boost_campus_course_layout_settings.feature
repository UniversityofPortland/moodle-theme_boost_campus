@theme @theme_boost_campus @theme_boost_campus_course_layout_settings
Feature: Configuring the theme_boost_campus plugin for the "Course Layout settings" tab
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

  Scenario: Enable "Section 0: Title"
    Given the following config values are set as admin:
      | config        | value   | plugin             |
      | section0title | yes     | theme_boost_campus |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    Then I should see "General" in the "li#section-0" "css_element"
    When I edit the section "0" and I fill the form with:
      | Custom                     | 1                           |
      | New value for Section name | This is the general section |
    Then I should see "This is the general section"

  Scenario: Enable "Course edit button"
    Given the following config values are set as admin:
      | config           | value | plugin             |
      | courseeditbutton | 1     | theme_boost_campus |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    Then I should see "Turn editing on" in the ".singlebutton" "css_element"
    When I click on "Turn editing on" "button"
    Then I should see "Turn editing off" in the ".singlebutton" "css_element"
    And I should see "Add an activity or resource"

  Scenario: Enable "Position of switch role information"
    Given the following config values are set as admin:
      | config                   | value | plugin             |
      | showswitchedroleincourse | yes   | theme_boost_campus |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I click on "Switch role to..." "link"
    And I click on "Student" "button"
    Then I should see "You are viewing this course currently with the role:"
    And I should not see "Turn editing on"
    When I click on "Return to my normal role" "link"
    Then I should see "Turn editing on"

  Scenario: Enable "Show hint in hidden courses"
    Given the following config values are set as admin:
      | config               | value | plugin             |
      | showhintcoursehidden | yes   | theme_boost_campus |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    When I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | Course visibility | Hide |
    And I click on "Save and display" "button"
    Then I should see "This course is currently hidden. Only enrolled teachers can access this course when hidden."

  Scenario: Enable "Show hint for guest access"
    Given the following config values are set as admin:
      | config                    | value | plugin             |
      | showhintcourseguestaccess | yes   | theme_boost_campus |
    And the following "users" exist:
      | username |
      | student2 |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "Users > Enrolment methods" in current page administration
    And I click on "Edit" "link" in the "Guest access" "table_row"
    And I set the following fields to these values:
      | Allow guest access | Yes |
    And I press "Save changes"
    And I follow "Log out" in the user menu
    When I log in as "student2"
    And I am on "Course 1" course homepage
    Then I should see "You are currently viewing this course as Guest."
    And I follow "Log out" in the user menu
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "Users > Enrolment methods" in current page administration
    And I click on "Enable" "link" in the "Self enrolment (Student)" "table_row"
    And I follow "Log out" in the user menu
    When I log in as "student2"
    And I am on "Course 1" course homepage
    Then I should see "To have full access to the course, you can self enrol into this course."
    And I click on "self enrol into this course" "link" in the ".course-guestaccess-infobox" "css_element"
    And I click on "Enrol me" "button"
    Then I should not see "You are currently viewing this course as Guest."

  @javascript
  Scenario: Enable "In course settings menu
    Given the following config values are set as admin:
      | config               | value | plugin             |
      | showsettingsincourse | yes   | theme_boost_campus |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I click on ".context-header-settings-menu [role=button]" "css_element"
    Then I should see "Course administration"

  # Dependent on setting showsettingsincourse
  @javascript
  Scenario: Set "Switch role to..." location(s) to "Just in the user menu"
    Given the following config values are set as admin:
      | config                               | value | plugin             |
      | showsettingsincourse                 | yes   | theme_boost_campus |
      | incoursesettingsswitchtoroleposition | no    | theme_boost_campus |
    And I log in as "admin"
    And I navigate to "Development > Purge caches" in site administration
    And I press "Purge all caches"
    And I am on "Course 1" course homepage
    And I click on ".context-header-settings-menu [role=button]" "css_element"
    Then I should not see "Switch role to"
    When I click on ".usermenu" "css_element"
    Then I should see "Switch role to..."

  # Dependent on setting showsettingsincourse
  @javascript
  Scenario: Set "Switch role to..." location(s) to "Just in the course settings"
    Given the following config values are set as admin:
      | config                               | value | plugin             |
      | showsettingsincourse                 | yes   | theme_boost_campus |
      | incoursesettingsswitchtoroleposition | yes   | theme_boost_campus |
    And I log in as "admin"
    And I navigate to "Development > Purge caches" in site administration
    And I press "Purge all caches"
    And I am on "Course 1" course homepage
    And I click on ".context-header-settings-menu [role=button]" "css_element"
    Then I should see "Switch role to"
    When I click on ".usermenu" "css_element"
    Then I should not see "Switch role to..."

  # Dependent on setting showsettingsincourse
  @javascript
  Scenario: Set "Switch role to..." location(s) to "In both places: in the user menu and in the course settings"
    Given the following config values are set as admin:
      | config                               | value | plugin             |
      | showsettingsincourse                 | yes   | theme_boost_campus |
      | incoursesettingsswitchtoroleposition | both  | theme_boost_campus |
    And I log in as "admin"
    And I navigate to "Development > Purge caches" in site administration
    And I press "Purge all caches"
    And I am on "Course 1" course homepage
    And I click on ".context-header-settings-menu [role=button]" "css_element"
    Then I should see "Switch role to"
    When I click on ".usermenu" "css_element"
    Then I should see "Switch role to..."
