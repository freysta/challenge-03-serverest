*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections
Resource        usuarios_keywords.robot
Resource        produtos_keywords.robot
Resource        carrinhos_keywords.robot

*** Variables ***
${BASE_URL}     https://serverest.dev

*** Keywords ***
Conectar na API ServeRest
    Create Session    serverest    ${BASE_URL}
