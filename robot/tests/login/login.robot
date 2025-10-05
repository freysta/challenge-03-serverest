*** Settings ***
Documentation     Testes de funcionalidade do módulo de Login
Resource          ../../resources/base.resource
Resource          ../../resources/users.resource
Resource          ../../resources/login.resource
Suite Setup       Cadastrar Novo Usuario e Salvar ID
Suite Teardown    Deletar Usuario Criado

*** Test Cases ***
CT01: Realizar login com sucesso
    [Documentation]    Valida o login de um usuário com credenciais válidas.
    [Tags]    login    positivo    smoke
    Realizar Login e Salvar Token

CT02: Tentar realizar login com credenciais inválidas
    [Documentation]    Valida que não é possível realizar login com credenciais inválidas.
    [Tags]    login    negativo    validacao
    Tentar Login Com Credenciais Invalidas
