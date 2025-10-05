*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           OperatingSystem
Library           DateTime

*** Variables ***
${BASE_URL}       https://compassuol.serverest.dev
&{ENDPOINTS}      usuarios=/usuarios    login=/login    produtos=/produtos    carrinhos=/carrinhos    concluir_compra=/carrinhos/concluir-compra    cancelar_compra=/carrinhos/cancelar-compra
&{MENSAGENS}      cadastro_sucesso=Cadastro realizado com sucesso    exclusao_sucesso=Registro excluído com sucesso    email_duplicado=Este email já está sendo usado    login_invalido=Email e/ou senha inválidos    token_invalido=Token de acesso ausente, inválido, expirado ou usuário do token não existe mais    produto_duplicado=Já existe produto com esse nome    produto_em_carrinho=Não é permitido excluir produto que faz parte de carrinho    carrinho_duplicado=Não é permitido ter mais de 1 carrinho    estoque_reabastecido=Registro excluído com sucesso. Estoque dos produtos reabastecido
${TIMEOUT}        30

*** Keywords ***
Conectar na API ServeRest
    [Documentation]    Cria sessão com a API ServeRest
    Create Session    serverest    ${BASE_URL}    verify=${True}    timeout=${TIMEOUT}

Validar Status Code
    [Arguments]    ${response}    ${expected_status}
    [Documentation]    Valida o status code da resposta
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    ...    msg=Status code esperado: ${expected_status}, obtido: ${response.status_code}

Validar Mensagem
    [Arguments]    ${response}    ${mensagem_esperada}    ${campo_da_mensagem}=message
    [Documentation]    Valida uma mensagem na resposta.
    ${json_response}=    Set Variable    ${response.json()}
    ${mensagem_atual}=    Get From Dictionary    ${json_response}    ${campo_da_mensagem}
    Should Be Equal    ${mensagem_atual}    ${mensagem_esperada}
    ...    msg=No campo '${campo_da_mensagem}', a mensagem esperada era '${mensagem_esperada}', mas foi obtida '${mensagem_atual}'.

Obter Valor Do Campo
    [Arguments]    ${response}    ${campo}
    [Documentation]    Obtém o valor de um campo do JSON
    ${json_response}=    Set Variable    ${response.json()}
    ${valor}=    Get From Dictionary    ${json_response}    ${campo}
    RETURN    ${valor}

Extrair ID da Resposta
    [Arguments]    ${response_json}
    [Documentation]    Extrai o _id do JSON de resposta
    ${id}=    Get From Dictionary    ${response_json}    _id
    RETURN    ${id}

Gerar Headers Com Token
    [Arguments]    ${token}
    [Documentation]    Retorna headers com token de autenticação
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Authorization=${token}
    RETURN    ${headers}