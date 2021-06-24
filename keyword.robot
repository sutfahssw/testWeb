*** Settings ***
Library  SeleniumLibrary
Library  Collections 
Resource  variables.robot

*** Keywords ***

Open url
    Open Browser  ${url}  chrome  options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window


Input username in login page with "${username}"
    Wait Until Element Is Visible  id=username-input
    Input Text  id=username-input  ${username}

Input password in login page with "${password}"
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

Click button bento menu
    Wait Until Element Is Visible  //*[@id="menu-container"]
    Click Element  //*[@id="menu-container"]//*[@class="app-menu-icon"]

Click button user management 
    Wait Until Element Is Visible  //*[@id="menu-container"]//*[@class="app-menu-icon"]
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

Should show new username after edit with "${newUserShow}"
    Wait Until Element Is Visible  id=user-item-list
    Element Should Contain  class=profile-data   ${newUserShow}

Should show name "${usernameiInList}" in user list   
    Wait Until Element Is Visible  //*[@id="user-item-list"]//*[@class="list"]
    Element Should Contain  //*[@id="user-item-list"]//*[@class="list"]  ${usernameiInList}
    Should Be Equal  ${usernameiInList}  ${expectUsernameInList}

Should have number of username after add user is "${expectNumberOfUsername}"
    Wait Until Element Is Visible  id=user-item-list                           
    ${profileItem} =  Get Element Count  //*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]
    Log To Console  In list user have ${profileItem} user
    Should Be Equal As Integers  ${expectNumberOfUsername}  ${profileItem} 

Should have number of user after remove is "${expectNumberOfUsername}"
    Wait Until Element Is Visible  id=user-item-list                           
    ${profileItem} =  Get Element Count  //*[@id="user-item-list"]//*[@class="list"]//*[@class="list-item-detail"]
    Log To Console  In list user have ${profileItem} user
    Should Be Equal As Integers  ${expectNumberOfUsername}  ${profileItem} 

Not show name "${userWannaRemove}" in user list
    Wait Until Element Is Visible  id=user-item-list
    Element Should Not Contain  //*[@id="user-item-list"]//*[@class="list"]  ${userWannaRemove}

Show user info in "${typeProfile}" should be "${detialUser}"
    Wait Until Element Is Visible  id=user-collapse-profile
    ${profileItem} =  Get Element Count  //*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-gray profile-label"]
    
    FOR  ${i}  IN RANGE  ${profileItem}
        ${profileItemText} =  Get Text  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-gray profile-label"])\[${i}+1]
        ${type} =  Set Variable  ${profileItemText}
        
        IF  '${type}' == '${typeProfile}'
            Log To Console  \ntype is ${type}
            ${profileItemText2} =  Get Text  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-black profile-detail"])\[${i}+1]  
            ${detail} =  Set Variable  ${profileItemText2}
            Log to console  detial is ${detail}
            Should Be Equal  ${type}${detail}  ${typeProfile}${detialUser}  
            END 
                
    END
    
    
    
    # Wait Until Element Is Visible  id=user-collapse-profile
    # ${profileItem} =  Get Element Count  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-black profile-detail"])
    # FOR  ${i}  IN RANGE  ${profileItem}
    #     ${profileItemDetail} =  Get Text  (//*[@id="user-collapse-profile"]//*[@class="profile-data"]//*[@class="profile-item"]//*[@class="text-black profile-detail"])\[${i}+1]
    #     @{detail} =  Create List  ${profileItemDetail}
    #     # Log to console  @{detail}
    #     # Log to console  ----------
    #     IF  '${typeProfile}' == 'First Name:'
    #         ${getDetail} =  Get From List  ${detail}  0
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
            
    #     ELSE IF  '${typeProfile}' == 'Middle Name:'
    #         ${getDetail} =  Get From List  ${detail}  1
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
            

    #     ELSE IF  '${typeProfile}' == 'Last Name:'
    #         ${getDetail} =  Get From List  ${detail}  2
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
            

    #     ELSE IF  '${typeProfile}' == 'Nickname:'
    #         ${getDetail} =  Get From List  ${detail}  3
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
        
    #     ELSE IF  '${typeProfile}' == 'User Name:'
    #         ${getDetail} =  Get From List  ${detail}  4
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
        
    #     ELSE IF  '${typeProfile}' == 'Email:'
    #         ${getDetail} =  Get From List  ${detail}  5
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
        
    #     ELSE IF  '${typeProfile}' == 'Phone:'
    #         ${getDetail} =  Get From List  ${detail}  6
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
        
    #     ELSE IF  '${typeProfile}' == 'Department:'
    #         ${getDetail} =  Get From List  ${detail}  7
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
        
    #     ELSE IF  '${typeProfile}' == 'Position:'
    #         ${getDetail} =  Get From List  ${detail}  8
    #         Log To Console  detail = ${getDetail}
    #         Should Be Equal  ${detialUser}  ${getDetail}
    #         Exit For Loop
            
    #              END 
                
    #         END

Should show new username after edit in User Info with "${newUserAfterEdit}"
    Wait Until Element Is Visible  //*[@id="user-collapse-profile"]//*[@class="ant-collapse-content ant-collapse-content-active"]
    Element Should Contain  class=profile-data   ${newUserAfterEdit}