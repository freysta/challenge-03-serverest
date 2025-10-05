# Configurações da API ServeRest
BASE_URL = "https://compassuol.serverest.dev"

ENDPOINTS = {
    "usuarios": "/usuarios",
    "login": "/login",
    "produtos": "/produtos", 
    "carrinhos": "/carrinhos",
    "concluir_compra": "/carrinhos/concluir-compra",
    "cancelar_compra": "/carrinhos/cancelar-compra"
}

MENSAGENS = {
    "cadastro_sucesso": "Cadastro realizado com sucesso",
    "exclusao_sucesso": "Registro excluído com sucesso",
    "email_duplicado": "Este email já está sendo usado",
    "login_invalido": "Email e/ou senha inválidos",
    "produto_duplicado": "Já existe produto com esse nome",
    "produto_em_carrinho": "Não é permitido excluir produto que faz parte de carrinho",
    "carrinho_duplicado": "Não é permitido ter mais de 1 carrinho",
    "estoque_reabastecido": "Registro excluído com sucesso. Estoque dos produtos reabastecido"
}