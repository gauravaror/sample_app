
    Feature:  Signing in

        Scenario: Unsuccessful signin
        Given a user visit the signin page
        When he submit invalid signin information
        Then he should see an error message
        

        Scenario: Successful signin
        Given a user visit the signin page
        And he has an account
        And he submit a valid signin information
        Then he should see his profile page
        And he should see a signout link

