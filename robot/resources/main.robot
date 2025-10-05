*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections
Resource        usuarios_keywords.robot
Resource        produtos_keywords.robot
Resource        carrinhos_keywords.robot

*** Variables ***
${URL_BASE}     https://serverest.dev

*** Keywords ***
Conectar na API ServeRest
    [Documentation]    Estabelece conexão com a API ServeRest para execução dos testes
    Create Session    serverest    ${URL_BASE}
