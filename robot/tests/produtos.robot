*** Settings ***
Suite Setup       Setup Global para Testes de Produto
Suite Teardown    Deletar Usuário Criado
Resource          ../resources/main.robot

*** Keywords ***
Setup Global para Testes de Produto
    Conectar na API ServeRest
    Cadastrar Novo Usuário e Salvar ID
    Realizar Login e Salvar Token

*** Test Cases ***
Cenário de Sucesso: Cadastrar e Deletar Produto com Autenticação
    Cadastrar Novo Produto e Salvar ID
    Deletar Produto Criado

Cenário de Falha: Tentar Excluir Produto Sem Token
    Cadastrar Novo Produto e Salvar ID
    Tentar Excluir Produto Sem Token e Validar Erro
    Deletar Produto Criado

Cenário de Limite: Validar Preço Zero
    [Documentation]    Testa que preço zero não é aceito
    Tentar Cadastrar Produto Com Preço Zero

Cenário de Limite: Validar Preço Negativo
    [Documentation]    Testa que preço negativo não é aceito
    Tentar Cadastrar Produto Com Preço Negativo

Cenário de Limite: Validar Quantidade Zero
    [Documentation]    Testa que quantidade zero não é aceita
    Tentar Cadastrar Produto Com Quantidade Zero

Cenário de Falha: Produto Duplicado
    [Documentation]    Valida erro ao tentar cadastrar produto com nome duplicado
    Cadastrar Novo Produto e Salvar ID
    Tentar Cadastrar Produto Duplicado
    Deletar Produto Criado
