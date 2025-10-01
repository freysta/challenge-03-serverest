*** Settings ***
Suite Setup       Conectar na API ServeRest
Resource          ../resources/main.robot

*** Test Cases ***
Cenário de Sucesso: Cadastro e Login de Usuário
    Cadastrar Novo Usuário e Salvar ID
    Realizar Login e Salvar Token
    Deletar Usuário Criado

Cenário de Falha: Tentar Cadastrar E-mail Duplicado
    Cadastrar Novo Usuário e Salvar ID
    Tentar Cadastrar Usuário Duplicado e Validar Erro
    Deletar Usuário Criado
