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
