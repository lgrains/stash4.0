Feature:
  As a non-registered user,
  I want to sign up
  So that I can stash and share

  Scenario: Signup
   # Given I have signed up as "user@example.com"
   Given I am logged in as "user@example.com"
   Then I should be on the home page
   And I should see "Welcome"
   And I should see "Logout"

