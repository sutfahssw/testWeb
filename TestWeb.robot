*** Settings ***
Library  SeleniumLibrary
Library  Collections

Resource  keyword.robot
Resource  variables.robot

Suite Setup  Open url  
Test Teardown  Click button logout
Suite Teardown  Close Browser

*** Test Cases ***

Scenario: Login account with correct address
    Input username in login page with "super_parking_all"                                
    Input password in login page with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    

Scenario: Add mellow user input all required field
    Input username in login page with "super_parking_all"                                
    Input password in login page with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"        
    Given Click button bento menu
    And Click button user management
    And Click add mellow user
    Then Should show text "Add User"
    Given Input new username with "test"
    And Input new password with "12345"
    And Input firstname with "test"
    And Input lastname with "new"
    And Select authentication with "Local database"
    And Click button add user 
    And Reload Page
    Then Should show name "test new" in user list
    And Should have number of username after add user is "3"
    Given Click name in list user with "test new"
    Show user info in "User Name:" should be "test"

Scenario: Add mellow user with same information
    Input username in login page with "super_parking_all"                                
    Input password in login page with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"        
    Given Click button bento menu
    And Click button user management
    And Click add mellow user
    Then Should show text "Add User"
    Given Input new username with "test"
    And Input new password with "12345"
    And Input firstname with "test"
    And Input lastname with "new"
    And Select authentication with "Local database"
    And Click button add user 
    Then Should show error with "Username or RFID already exists."
    Given Click close adding error
    And Click close add user
    And Click discard button

Scenario: Remove user
    Input username in login page with "super_parking_all"                                
    Input password in login page with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"        
    Given Click button bento menu
    And Click button user management
    And Click name in list user with "test new"
    And Click dropdown user
    And Click romove user
    And Click button comfirm remove user
    And Reload Page
    Should have number of user after remove is "2"
    Not show name "test new" in user list

Scenarion: Edit user
    Input username in login page with "super_parking_all"                                
    Input password in login page with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"        
    Given Click button bento menu
    And Click button user management
    And Click name in list user with "wwww wwwww"
    And Click dropdown user
    And Click edit user
    And Input new username with "skyy"
    And Click save button
    Should show new username after edit in User Info with "skyyy"
