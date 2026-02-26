*** Settings ***
Documentation     Demo E2E test for searching, sorting by low-to-high, and adding first available item to cart.
Library           SeleniumLibrary
Library           Collections
Library           ../libraries/AmazonValidationLib.py

*** Variables ***
${AMAZON_SEARCH_BOX}             id=twotabsearchtextbox
${SEARCH_RESULTS}                css=span[data-component-type="s-search-results"]  
${SORT_DROPDOWN}                 xpath=//span[@data-action="a-dropdown-button"][contains(.,"Sort by:")]
${LOW_TO_HIGH_OPTION}            css=a[data-value*="price-asc-rank"]
${PRICE_LOW_TO_HIGH_PROMPT}      xpath=//span[@class="a-dropdown-prompt"][contains(.,"Price: Low to High")]
                               
${FIRST_PRODUCT_IN_SEARCH_RESULTS}    xpath=//div[@data-component-type='s-search-result'][not(.//span[contains(text(), 'Sponsored')])]//button[@name='submit.addToCart']
${GO_TO_CART_BUTTON}             xpath=//a[@class="a-button-text"][contains(text(), "Go to Cart")]
${PRODUCT_COUNT_IN_CART}         xpath=//span[@id="nav-cart-count"]
${PRODUCT_PRICE_ELEMENTS}        xpath=//div[@data-component-type='s-search-result'][not(.//span[contains(text(), 'Sponsored')])][.//button[@name='submit.addToCart']]//span[@class='a-price']//span[@class='a-offscreen']
*** Keywords ***
Go To Amazon Homepage
    Go To    https://www.amazon.com/    
    Wait Until Element Is Visible         ${AMAZON_SEARCH_BOX}    
Search For Product   
    [Arguments]    ${product_name}
    Input Text     ${AMAZON_SEARCH_BOX}   ${product_name}
    Press Keys     ${AMAZON_SEARCH_BOX}   ENTER
    Wait Until Element Is Visible         ${SEARCH_RESULTS}    
Sort Results By Price Low To High
    Wait Until Element Is Visible         ${SORT_DROPDOWN}     
    Click Element                         ${SORT_DROPDOWN}
    Wait Until Element Is Visible         ${LOW_TO_HIGH_OPTION}     
    Click Element                         ${LOW_TO_HIGH_OPTION}
    Wait Until Element Is Visible         ${PRICE_LOW_TO_HIGH_PROMPT}
Verify Results Are Sorted From Lowest To Highest Price
    Wait Until Element Is Visible         ${FIRST_PRODUCT_IN_SEARCH_RESULTS}  
    ${price_elements}=   Get WebElements  ${PRODUCT_PRICE_ELEMENTS} 
    ${first_five_elements}=    Get Slice From List    ${price_elements}    0    5  # Check the first 5 products to verify sorting
    ${price_texts}=    Create List
    FOR    ${element}   IN    @{first_five_elements}  
        ${price_text}=    Get Element Attribute    ${element}    textContent
        Append To List    ${price_texts}    ${price_text} 
    END
    Verify Prices Are In Ascending Order    ${price_texts}
Add First Available Product To Cart 
    Click Element                         ${FIRST_PRODUCT_IN_SEARCH_RESULTS}

Verify Product Is Successfully Added To Cart
    Wait Until Element Is Visible         ${GO_TO_CART_BUTTON}
    Wait Until Element Is Visible         ${PRODUCT_COUNT_IN_CART}
    Element Text Should Be                ${PRODUCT_COUNT_IN_CART}    1