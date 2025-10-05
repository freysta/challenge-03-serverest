*** Settings ***
Documentation     Testes de funcionalidade do módulo de Produtos
Resource          ../../resources/base.resource
Resource          ../../resources/users.resource
Resource          ../../resources/products.resource
Resource          ../../resources/login.resource
Suite Setup       Setup Global para Testes de Produto
Suite Teardown    Deletar Usuario Criado

*** Keywords ***
Setup Global para Testes de Produto
    Conectar na API ServeRest
    Cadastrar Novo Usuario e Salvar ID
    Realizar Login e Salvar Token

*** Test Cases ***
CT01: Cadastrar e deletar produto com sucesso
    [Documentation]    Valida o cadastro e exclusão de um produto com sucesso.
    [Tags]    produtos    positivo    smoke
    Cadastrar Novo Produto e Salvar ID
    Deletar Produto Criado

CT02: Tentar excluir produto sem token
    [Documentation]    Valida que não é possível excluir um produto sem um token de autenticação.
    [Tags]    produtos    negativo    seguranca
    Cadastrar Novo Produto e Salvar ID
    Tentar Excluir Produto Sem Token e Validar Erro
    Deletar Produto Criado

CT03: Tentar cadastrar produto com preço zero
    [Documentation]    Valida que não é possível cadastrar um produto com preço zero.
    [Tags]    produtos    negativo    validacao
    Tentar Cadastrar Produto Com Preco Zero e Validar Erro

CT04: Tentar cadastrar produto com preço negativo
    [Documentation]    Valida que não é possível cadastrar um produto com preço negativo.
    [Tags]    produtos    negativo    validacao
    Tentar Cadastrar Produto Com Preco Negativo e Validar Erro

CT05: Tentar cadastrar produto com quantidade zero
    [Documentation]    Valida que não é possível cadastrar um produto com quantidade zero.
    [Tags]    produtos    negativo    validacao
    Tentar Cadastrar Produto Com Quantidade Zero e Validar Erro

CT06: Tentar cadastrar produto duplicado
    [Documentation]    Valida que não é possível cadastrar um produto com um nome que já existe.
    [Tags]    produtos    negativo    validacao
    Cadastrar Novo Produto e Salvar ID
    Tentar Cadastrar Produto Duplicado e Validar Erro
    Deletar Produto Criado