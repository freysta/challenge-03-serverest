from faker import Faker

fake = Faker("pt_BR")

def gerar_usuario(administrador="true"):
    """Gera dados de usuário válidos"""
    return {
        "nome": fake.name(),
        "email": fake.email(),
        "password": fake.password(length=8),
        "administrador": administrador,
    }

def gerar_usuario_email_invalido():
    """Gera usuário com email inválido"""
    return {
        "nome": fake.name(),
        "email": "email_invalido",
        "password": fake.password(length=8),
        "administrador": "true",
    }

def gerar_usuario_senha_curta():
    """Gera usuário com senha muito curta"""
    return {
        "nome": fake.name(),
        "email": fake.email(),
        "password": "123",
        "administrador": "true",
    }

def gerar_produto():
    """Gera dados de produto válidos"""
    return {
        "nome": f"Produto {fake.word()} {fake.random_number(digits=5)}",
        "preco": fake.random_int(min=10, max=1000),
        "descricao": fake.text(max_nb_chars=50),
        "quantidade": fake.random_int(min=1, max=100),
    }

def gerar_produto_preco_negativo():
    """Gera produto com preço negativo"""
    produto = gerar_produto()
    produto["preco"] = -100
    return produto

def gerar_produto_quantidade_negativa():
    """Gera produto com quantidade negativa"""
    produto = gerar_produto()
    produto["quantidade"] = -10
    return produto

def gerar_carrinho(produtos):
    """
    Gera dados de carrinho
    produtos: lista de dicts com idProduto e quantidade
    Exemplo: [{"idProduto": "abc123", "quantidade": 2}]
    """
    return {"produtos": produtos}
