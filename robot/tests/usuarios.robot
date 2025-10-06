*** Settings ***
Suite Setup       Conectar na API ServeRest
Resource          ../resources/base.resource
Resource          ../resources/users.resource

*** Test Cases ***
Cenario de Sucesso: Cadastro e Login de Usuario
    [Documentation]    Valida o fluxo completo de cadastro, login e exclusão de usuário
    [Tags]    usuarios    positivo    smoke
    Cadastrar Novo Usuario e Salvar ID
    Realizar Login e Salvar Token
    Deletar Usuario Criado

Cenario de Falha: Tentar Cadastrar Email Duplicado
    [Documentation]    Valida que não é possível cadastrar usuário com email já existente
    [Tags]    usuarios    negativo    validacao
    Cadastrar Novo Usuario e Salvar ID
    Tentar Cadastrar Usuario Duplicado e Validar Erro
    Deletar Usuario Criado

Cenario de Limite: Validar Senha Vazia
    [Documentation]    Testa que senha vazia não é aceita
    [Tags]    usuarios    limite    negativo
    Tentar Cadastrar Usuario Com Senha Vazia e Validar Erro

Cenario de Falha: Login Com Credenciais Invalidas
    [Documentation]    Valida mensagem de erro para login inválido
    [Tags]    login    negativo    validacao
    Tentar Login Com Credenciais Invalidas

Cenario Avancado: Teste de Idempotencia DELETE
    [Documentation]    Valida que DELETE pode ser executado várias vezes
    [Tags]    usuarios    avancado    idempotencia
    Teste de Idempotencia DELETE Usuario

Cenario Avancado: Teste de Listagem
    [Documentation]    Valida listagem de usuários da API
    [Tags]    usuarios    avancado    listagem
    Teste de Listagem Usuarios

Cenario de Segurança: Email Muito Longo
    [Documentation]    Testa se API valida tamanho máximo de email
    [Tags]    usuarios    seguranca    limite
    Teste de Email Muito Longo

Cenario de Segurança: Injeção SQL
    [Documentation]    Testa se API é vulnerável a injeção SQL
    [Tags]    usuarios    seguranca    sql_injection
    Teste de Injecao SQL no Email

Cenario de Performance: Rate Limiting
    [Documentation]    Testa se API tem limite de requisições
    [Tags]    usuarios    performance    rate_limit
    Teste de Rate Limiting
