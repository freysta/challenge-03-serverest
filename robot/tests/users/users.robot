*** Settings ***
Documentation     Testes de funcionalidade do módulo de Usuários
Resource          ../../resources/base.resource
Resource          ../../resources/users.resource
Resource          ../../resources/login.resource
Suite Setup       Conectar na API ServeRest
Suite Teardown    Deletar Usuario Criado

*** Test Cases ***
CT01: Cadastrar e fazer login de usuário com sucesso
    [Documentation]    Valida o fluxo completo de cadastro, login e exclusão de usuário.
    [Tags]    usuarios    positivo    smoke
    Cadastrar Novo Usuario e Salvar ID
    Realizar Login e Salvar Token

CT02: Tentar cadastrar email duplicado
    [Documentation]    Valida que não é possível cadastrar um usuário com um e-mail que já existe.
    [Tags]    usuarios    negativo    validacao
    Cadastrar Novo Usuario e Salvar ID
    Tentar Cadastrar Usuario Duplicado e Validar Erro

CT03: Tentar cadastrar usuário com senha curta
    [Documentation]    Valida que não é possível cadastrar um usuário com uma senha muito curta.
    [Tags]    usuarios    limite    negativo
    Tentar Cadastrar Usuario Com Senha Curta e Validar Erro