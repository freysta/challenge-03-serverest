*** Settings ***
Suite Setup       Conectar na API ServeRest
Resource          ../resources/main.robot

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

Cenario de Limite: Validar Tamanho Minimo de Senha
    [Documentation]    Testa o limite mínimo de 5 caracteres para senha
    [Tags]    usuarios    limite    negativo
    Tentar Cadastrar Usuario Com Senha de 4 Caracteres

Cenario de Limite: Validar Senha Com 5 Caracteres
    [Documentation]    Testa o limite exato de 5 caracteres (deve passar)
    [Tags]    usuarios    limite    positivo
    Tentar Cadastrar Usuario Com Senha de 5 Caracteres

Cenario de Limite: Validar Senha Com 10 Caracteres
    [Documentation]    Testa senha com 10 caracteres (deve passar)
    [Tags]    usuarios    limite    positivo
    Tentar Cadastrar Usuario Com Senha de 10 Caracteres

Cenario de Falha: Login Com Credenciais Invalidas
    [Documentation]    Valida mensagem de erro para login inválido
    [Tags]    login    negativo    validacao
    Tentar Login Com Credenciais Invalidas
