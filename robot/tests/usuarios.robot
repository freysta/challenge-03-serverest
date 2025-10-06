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

Cenario de Limite: Validar Tamanho Minimo de Senha
    [Documentation]    Testa o limite mínimo de 3 caracteres para senha
    [Tags]    usuarios    limite    negativo
    Tentar Cadastrar Usuario Com Senha Muito Curta e Validar Erro

Cenario de Falha: Login Com Credenciais Invalidas
    [Documentation]    Valida mensagem de erro para login inválido
    [Tags]    login    negativo    validacao
    Tentar Login Com Credenciais Invalidas

Cenario Avancado: Teste de Idempotencia DELETE
    [Documentation]    Valida que DELETE pode ser executado várias vezes
    [Tags]    usuarios    avancado    idempotencia
    Teste de Idempotencia DELETE Usuario

Cenario Avancado: Teste de Paginacao
    [Documentation]    Valida paginação na listagem de usuários
    [Tags]    usuarios    avancado    paginacao
    Teste de Paginacao Listar Usuarios
