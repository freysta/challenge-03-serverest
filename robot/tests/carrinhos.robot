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

Cenário de Sucesso: Cancelar Compra e Restaurar Estoque
    [Documentation]    Valida o cancelamento de compra e restauração do estoque
    Criar Carrinho Com Produto e Salvar ID
    Cancelar Compra e Validar Restauração de Estoque

Cenário de Falha: Produto Inexistente no Carrinho
    [Documentation]    Testa erro ao tentar adicionar produto inexistente
    Tentar Criar Carrinho Com Produto Inexistente

Cenário de Falha: Quantidade Maior Que Estoque
    [Documentation]    Testa erro quando quantidade solicitada excede estoque
    Tentar Criar Carrinho Com Quantidade Maior Que Estoque

Cenário de Falha: Múltiplos Carrinhos Para Mesmo Usuário
    [Documentation]    Valida que usuário não pode ter mais de um carrinho
    Criar Carrinho Com Produto e Salvar ID
    Tentar Criar Segundo Carrinho Para Mesmo Usuário
