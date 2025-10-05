*** Settings ***
Suite Setup       Setup Global para Testes de Carrinho
Suite Teardown    Deletar Dados de Teste
Resource          ../resources/base.resource
Resource          ../resources/users.resource
Resource          ../resources/products.resource
Resource          ../resources/carts.resource

*** Keywords ***
Setup Global para Testes de Carrinho
    Conectar na API ServeRest
    Cadastrar Novo Usuario e Salvar ID
    Realizar Login e Salvar Token
    Cadastrar Novo Produto e Salvar ID

Deletar Dados de Teste
    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Deletar Produto Criado
    Deletar Usuario Criado

*** Test Cases ***
Cenário de Sucesso: Fluxo Completo de Carrinho
    [Teardown]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Criar Carrinho Com Produto e Salvar ID
    Concluir Compra e Limpar ID

Cenário de Integração: Não Deve Excluir Produto que Está em um Carrinho
    [Documentation]    Valida a regra de negócio que impede a exclusão de um produto vinculado a um carrinho.
    [Teardown]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Criar Carrinho Com Produto e Salvar ID
    Tentar Excluir Produto que Esta em um Carrinho

Cenário de Sucesso: Cancelar Compra e Restaurar Estoque
    [Documentation]    Valida o cancelamento de compra e restauração do estoque
    [Setup]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Criar Carrinho Com Produto e Salvar ID
    Cancelar Compra e Validar Restauracao de Estoque

Cenário de Falha: Produto Inexistente no Carrinho
    [Documentation]    Testa erro ao tentar adicionar produto inexistente
    [Setup]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Tentar Criar Carrinho Com Produto Inexistente

Cenário de Falha: Quantidade Maior Que Estoque
    [Documentation]    Testa erro quando quantidade solicitada excede estoque
    [Setup]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Tentar Criar Carrinho Com Quantidade Maior Que Estoque

Cenário de Falha: Múltiplos Carrinhos Para Mesmo Usuário
    [Documentation]    Valida que usuário não pode ter mais de um carrinho
    [Teardown]    Run Keyword And Ignore Error    Concluir Compra e Limpar ID
    Criar Carrinho Com Produto e Salvar ID
    Tentar Criar Segundo Carrinho Para Mesmo Usuario
