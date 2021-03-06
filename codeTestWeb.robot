*** Settings ***
Library  SeleniumLibrary

Suite Setup  Open url  
Test Teardown  Click button logout
Suite Teardown  Close Browser

*** Variables ***

*** Keywords ***

Open url
    Open Browser  https://10.10.20.191:31608/#  gc  options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window


Input username with "${username}"
    Wait Until Element Is Visible  id=username-input
    Input Text  id=username-input  ${username}

Input password with "${password}"
    Wait Until Element Is Visible  id=password-input
    Input Text  id=password-input  ${password}

Click login button
    Wait Until Element Is Visible  id=login-btn 
    Click Button  id=login-btn  

Should show title name with "${titletext}"
    Title Should Be  ${titletext}

Click button logout    
    Wait Until Element Is Visible  //*[@id="menu-container"]
    Click Element  //*[@id="menu-container"]/i[2]/div/span
    Click Element  (//*[@id="profile-menu-list"]//*[@id="logout-btn"])  

Click button user management
    Wait Until Element Is Visible  //*[@id="menu-container"]
    Click Element  //*[@id="menu-container"]/i[1]
    Click Element  //*[@id="app-icon-um"]

Click add mellow user
    Wait Until Element Is Visible  //*[@class="button-container"] 
    Click Element  //*[@id="add-enrollment-button-dropdown-toggle-btn"]
    Wait Until Element Is Visible  //*[@class="ant-dropdown-menu-item"]
    Click Element  //*[@id="add-user-button"]

Should show text "${textAddUser}"
    Wait Until Element Contains  //*[@class="content-modal-title"]  ${textAddUser}

Select authentication with "${authentication}"
    Wait Until Element Is Visible  id=authen_type-input-container
    Click Element  //*[@id="authen_type-input-select"]
    IF  '${authentication}' == 'Use config as previously set in organization management'
        Click Element  //*[@id="authen_type-input-useconfigaspreviouslysetinorganizationmanagement-btn"]
    ELSE IF  '${authentication}' == 'Local database'
        Click Element  //*[@id="authen_type-input-localdatabase-btn"]
    END
    #Get Selected List Label  (//*[@class=" css-o2o2vd"]//*[@class=" css-15z1hn5-singleValue"])

Input new username with "${newUsername}"
    Wait Until Element Is Visible  id=username-input-container
    Input Text  id=username-input  ${newUsername}

Input new password with "${newPassword}"
    Wait Until Element Is Visible  id=password-input-container
    Input Password  id=password-input  ${newPassword}

Input firstname with "${firstname}"
    Wait Until Element Is Visible  id=firstname-input-container
    Input Text  id=firstname-input  ${firstname}

Input lastname with "${lastname}"
    Wait Until Element Is Visible  id=lastname-input-container
    Input Text  id=lastname-input  ${lastname}

Click button add user
    Wait Until Element Is Visible  class=content-modal-header
    Click Button  id=create-user

Should show error with "${errorAlready}"
    Wait Until Element Is Visible  class=confirm-modal-container
    Element Should Contain  class=confirm-modal-container  ${errorAlready}

Click close adding error
    Wait Until Element Is Visible  id=close-duplicate-user
    Click Element  id=close-duplicate-user

Click close add user
    Wait Until Element Is Visible  id=close-duplicate-user
    Click Element  id=close-content-modal-btn

Click discard button
    Wait Until Element Is Visible  id=discard
    Click Button  id=discard


Click dropdown user
    Wait Until Element Is Visible  id=toggle-option-dropdown-user
    Click Element  id=toggle-option-dropdown-user

Click romove user
    Wait Until Element Is Visible  id=option-list
    Click Element  id=option-remove-user

Click button comfirm remove user
    Wait Until Element Is Visible  id=confirm-delete-user
    Click Button  id=confirm-delete-user

Click name in list user with "${fiastnameAndLastnameiInList}"  
    Wait Until Element Is Visible  id=user-item-list
    ${count} =  Get Element Count  (//*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]//*[@class="text-black overflow-ellipse false "])
    #Log To Console  ${count}
    FOR  ${i}  IN RANGE  ${count}
        ${text2} =  Get Text  (//*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]//*[@class="text-black overflow-ellipse false "])\[${i}+1]
        #Log to console  ${text2}
        IF  '${text2}' == '${fiastnameAndLastnameiInList}'
            # Log To Console  ${text2}
            Click Element  (//*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"])\[${i}+1]
            Exit For Loop
        END
    END

Click edit user
    Wait Until Element Is Visible  id=option-list
    Click Element  id=option-update-user

Click save button
    Wait Until Element Is Visible  id=update-user
    Click Element  id=update-user

Should show new user with "${newUserShow}"
    Wait Until Element Is Visible  id=user-item-list
    Element Should Contain  class=profile-data   ${newUserShow}

Should show name "${usernameiInList}" in user list  
    Wait Until Element Is Visible  id=user-item-list
    ${profileItem} =  Get Element Count  //*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]
    Log To Console  In list user have ${profileItem} user
    Element Should Contain  class=list  ${usernameiInList}

Not show name "${userWannaRemove}" in user list  
    Wait Until Element Is Visible  id=user-item-list
    ${profileItem} =  Get Element Count  //*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]
    Log To Console  In list user have ${profileItem} user
    Wait Until Element Is Visible  id=user-item-list
    Element Should Not Contain  //*[@id="user-item-list"]//*[@class="list"]  ${userWannaRemove}

Should show user info in "${typeProfile}" with "${dataProfile}"
    Wait Until Element Is Visible  id=user-collapse-profile
    ${profileItem} =  Get Element Count  //*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-gray profile-label"]
    #Log To Console  ${profileItem}
    
    FOR  ${a}  IN RANGE  ${profileItem}
        ${profileItemText} =  Get Text  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-gray profile-label"])\[${a}+1]
        #Log To Console  ${profileItemText}
        ${type} =  Set Variable  ${profileItemText}
        
        IF  '${type}' == '${typeProfile}'
            #Log To Console  \n${type}
            ${profileItem2} =  Get Element Count  //*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-black profile-detail"]
            #Log To Console  ${profileItem2}
            
            FOR  ${b}  IN RANGE  ${profileItem2}
            ${profileItemText2} =  Get Text  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-black profile-detail"])\[${b}+1]  
            #Log To Console  ${profileItemText2}
            ${detail} =  Set Variable  ${profileItemText2}
            #Log To Console  ${detail}
                IF  '${detail}' == '${dataProfile}'
                #Log To Console  \n data is ${detail}
                Should Be Equal  ${type}${detail}  ${typeProfile}${dataProfile}  
        

                END 
                
            END

        END
    END


*** Test Cases ***
Scenario: Login account with correct address
    Given Input username with "super_parking_all"
    And Input password with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    

Scenario: Add mellow user input all required field   
    Given Input username with "super_parking_all"
    And Input password with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    Given Click button user management
    And Click add mellow user
    Then Should show text "Add User"
    Given Input new username with "test"
    And Input new password with "12345"
    And Input firstname with "test"
    And Input lastname with "new"
    And Select authentication with "Local database"
    And Click button add user 
    ANd Reload Page
    Then Should show name "test new" in user list
    Given Click name in list user with "test name"
    Then Should show user info in "User Name:" with "test"
    
    
Scenatio: Add mellow user with same information
    Given Input username with "super_parking_all"
    And Input password with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    Given Click button user management
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
    Given Input username with "super_parking_all"
    And Input password with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    Given Click button user management
    And Click name in list user with "test new"
    And Click dropdown user
    And Click romove user
    And Click button comfirm remove user
    And Reload Page
    Then Not show name "test new" in user list

Scenarion: Edit user
    Given Input username with "super_parking_all"
    And Input password with "password"
    And Click Login Button
    Then Should show title name with "Mellow Matic"
    Given Click button user management
    And Click name in list user with "wwww wwwww"
    And Click dropdown user
    And Click edit user
    And Input new username with "sky"
    And Click save button
    Then Should show new user with "sky"
