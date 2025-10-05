import json
from robot.api.deco import keyword
from faker import Faker
import time

@keyword("Extrair ID da Resposta")
def extrair_id_resposta(response_json):
    """Extrai o ID do JSON de resposta"""
    if isinstance(response_json, str):
        response_json = json.loads(response_json)
    return response_json.get("_id", "")

@keyword("Gerar Email Único")
def gerar_email_unico():
    """Gera um email único para testes"""
    fake = Faker("pt_BR")
    timestamp = int(time.time() * 1000)
    return f"teste_{timestamp}_{fake.user_name()}@qa.com.br"

@keyword("Validar Estrutura Usuario")
def validar_estrutura_usuario(usuario):
    """Valida se o usuário contém os campos obrigatórios"""
    if isinstance(usuario, str):
        usuario = json.loads(usuario)
    campos_obrigatorios = ["nome", "email", "password", "administrador", "_id"]
    for campo in campos_obrigatorios:
        if campo not in usuario:
            raise AssertionError(
                f"Campo '{campo}' não encontrado na estrutura do usuário"
            )
    return True

@keyword("Validar Estrutura Produto")
def validar_estrutura_produto(produto):
    """Valida se o produto contém os campos obrigatórios"""
    if isinstance(produto, str):
        produto = json.loads(produto)
    campos_obrigatorios = ["nome", "preco", "descricao", "quantidade", "_id"]
    for campo in campos_obrigatorios:
        if campo not in produto:
            raise AssertionError(
                f"Campo '{campo}' não encontrado na estrutura do produto"
            )
    return True

@keyword("Converter String Para JSON")
def converter_string_para_json(string_json):
    """Converte string JSON para objeto Python"""
    return json.loads(string_json)
