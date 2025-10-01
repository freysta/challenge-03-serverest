*** Settings ***
Suite Setup       Setup Global para Testes de Carrinho
Suite Teardown    Deletar Dados de Teste
Resource          ../resources/main.robot

*** Keywords ***
Setup Global para Testes de Carrinho
    Conectar na API ServeRest
    Cadastrar Novo Usuário e Salvar ID
    Realizar Login e Salvar Token
    Cadastrar Novo Produto e Salvar ID

Deletar Dados de Teste
    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Deletar Produto Criado
    Deletar Usuário Criado

*** Test Cases ***
Cenário de Sucesso: Fluxo Completo de Carrinho
    Criar Carrinho Com Produto e Salvar ID
    Concluir Compra e Limpar ID

Cenário de Integração: Não Deve Excluir Produto que Está em um Carrinho
    [Documentation]    Valida a regra de negócio que impede a exclusão de um produto vinculado a um carrinho.
    Criar Carrinho Com Produto e Salvar ID
    Tentar Excluir Produto que Está em um Carrinho
