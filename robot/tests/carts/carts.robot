*** Settings ***
Documentation     Testes de funcionalidade do módulo de Carrinhos
Resource          ../../resources/base.resource
Resource          ../../resources/users.resource
Resource          ../../resources/products.resource
Resource          ../../resources/carts.resource
Resource          ../../resources/login.resource
Suite Setup       Setup Global para Testes de Carrinho
Suite Teardown    Deletar Dados de Teste

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
CT01: Criar e concluir carrinho com sucesso
    [Documentation]    Valida o fluxo completo de criação e conclusão de um carrinho de compras.
    [Tags]    carrinhos    positivo    smoke
    Criar Carrinho Com Produto e Salvar ID
    Concluir Compra e Limpar ID

CT02: Tentar excluir produto que está em um carrinho
    [Documentation]    Valida a regra de negócio que impede a exclusão de um produto que está em um carrinho.
    [Tags]    carrinhos    negativo    integracao
    Criar Carrinho Com Produto e Salvar ID
    Tentar Excluir Produto que Esta em um Carrinho

CT03: Cancelar compra e restaurar estoque
    [Documentation]    Valida o cancelamento de uma compra e a restauração do estoque do produto.
    [Tags]    carrinhos    positivo
    Criar Carrinho Com Produto e Salvar ID
    Cancelar Compra e Validar Restauracao de Estoque

CT04: Tentar criar carrinho com produto inexistente
    [Documentation]    Valida que não é possível criar um carrinho com um produto que não existe.
    [Tags]    carrinhos    negativo    validacao
    Tentar Criar Carrinho Com Produto Inexistente

CT05: Tentar criar carrinho com quantidade maior que estoque
    [Documentation]    Valida que não é possível criar um carrinho com uma quantidade de produto maior que a disponível em estoque.
    [Tags]    carrinhos    negativo    validacao
    Tentar Criar Carrinho Com Quantidade Maior Que Estoque

CT06: Tentar criar segundo carrinho para mesmo usuário
    [Documentation]    Valida que não é permitido criar mais de um carrinho para o mesmo usuário.
    [Tags]    carrinhos    negativo    validacao
    Criar Carrinho Com Produto e Salvar ID
    Tentar Criar Segundo Carrinho Para Mesmo Usuario