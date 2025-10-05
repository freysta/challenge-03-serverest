# -*- coding: utf-8 -*-
"""
Payloads e dados de teste para a API ServeRest
"""

import time
from faker import Faker

fake = Faker('pt_BR')

def gerar_usuario_valido():
    """Gera dados válidos para cadastro de usuário"""
    timestamp = str(int(time.time()))
    return {
        "nome": f"Usuario Teste {timestamp}",
        "email": f"usuario.teste.{timestamp}@qa.com.br",
        "password": "senha123",
        "administrador": "true"
    }

def gerar_produto_valido():
    """Gera dados válidos para cadastro de produto"""
    timestamp = str(int(time.time()))
    return {
        "nome": f"Produto Teste {timestamp}",
        "preco": 150,
        "descricao": "Produto para testes automatizados",
        "quantidade": 100
    }

def gerar_produto_preco_negativo():
    """Gera produto com preço negativo para teste de limite"""
    timestamp = str(int(time.time()))
    return {
        "nome": f"Produto Negativo {timestamp}",
        "preco": -10,
        "descricao": "Produto com preço negativo",
        "quantidade": 10
    }

def gerar_carrinho_valido(id_produto):
    """Gera dados válidos para criação de carrinho"""
    return {
        "produtos": [
            {
                "idProduto": id_produto,
                "quantidade": 1
            }
        ]
    }

def gerar_usuario_senha_curta():
    """Gera usuário com senha de 4 caracteres"""
    timestamp = str(int(time.time()))
    return {
        "nome": f"Usuario Senha Curta {timestamp}",
        "email": f"senha.curta.{timestamp}@qa.com.br", 
        "password": "1234",
        "administrador": "true"
    }