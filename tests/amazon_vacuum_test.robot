*** Settings ***
Documentation
Resource         ../resources/amazon_keywords.resource
Resource         ../resources/common.resource
Test Setup       Begin Web Test
Test Teardown    End Web Test
# run script: robot -d results tests/amazon_vacuum_test.robot
*** Test Cases ***
Find Cheapest Robot Vacuum And Add To Cart
    Go To Amazon Homepage
    Search For Product    robot vacuum cleaner
    Sort Results By Price Low To High
    Verify Results Are Sorted From Lowest To Highest Price
    Add First Available Product To Cart
    Verify Product Is Successfully Added To Cart

