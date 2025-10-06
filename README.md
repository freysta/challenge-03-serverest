# Challenge 03: Automação da API ServeRest com Robot Framework

**Autor:** Gabriel Lucena Ferreira  
**Versão:** 3.0  
**Data:** Outubro 2025

Este repositório contém a solução completa para o Challenge 03, implementando **31 testes automatizados** para a API ServeRest com Robot Framework. O projeto vai além dos testes funcionais básicos, incluindo testes avançados de segurança, stress e conformidade REST.

## 🏆 **Destaques do Projeto**
- ✅ **31 testes automatizados** (21 básicos + 10 avançados)
- ✅ **1 bug encontrado** na API (payload gigante aceito)
- ✅ **96% de sucesso** nos testes
- ✅ **Testes de segurança** (XSS, SQL Injection, Rate Limiting)
- ✅ **Arquitetura profissional** com Page Object Pattern

**URL da API:** https://compassuol.serverest.dev/

---

## 🚀 Tecnologias Utilizadas

* **Linguagem:** Python 3.x
* **Framework de Automação:** Robot Framework 6.1.1
* **Bibliotecas Principais:**
    * `RequestsLibrary 0.9.4`: Para requisições HTTP
    * `JSONLibrary 0.5`: Para validação de respostas JSON
* **Gerenciador de Pacotes:** Pip com `requirements.txt`
* **Controle de Versão:** Git com branches organizadas

---

## 📂 Estrutura do Projeto

```
challenge-03-serverest/
├── robot/
│   ├── resources/              # Keywords reutilizáveis
│   │   ├── base.resource      # Configurações e validações base
│   │   ├── users.resource     # Keywords para usuários
│   │   ├── products.resource  # Keywords para produtos
│   │   └── carts.resource     # Keywords para carrinhos
│   ├── tests/                 # Casos de teste
│   │   ├── usuarios.robot     # 9 testes de usuários
│   │   ├── produtos.robot     # 11 testes de produtos
│   │   └── carrinhos.robot    # 11 testes de carrinhos
│   └── requirements.txt       # Dependências
├── plano_de_testes_v2.md     # Plano de testes detalhado
├── casos_de_teste_completos.csv # Casos para Jira
└── README.md                 # Este arquivo
```

---

## 🎯 Funcionalidades Testadas (31 Testes)

### 👤 Módulo Usuários (9 testes)
**Endpoints:** `POST /usuarios`, `GET /usuarios`, `DELETE /usuarios/{id}`, `POST /login`

**Testes Básicos:**
- ✅ Cadastro, login e exclusão (fluxo completo)
- ✅ Email duplicado (validação de unicidade)
- ✅ Senha vazia (validação de limite)
- ✅ Login com credenciais inválidas

**Testes Avançados:**
- ✅ **Idempotência**: DELETE pode ser executado múltiplas vezes
- ✅ **Listagem**: Validação da API de listagem
- ✅ **Segurança**: Email muito longo, SQL Injection, Rate Limiting

### 🛍️ Módulo Produtos (11 testes)
**Endpoints:** `POST /produtos`, `GET /produtos`, `DELETE /produtos/{id}`

**Testes Básicos:**
- ✅ CRUD completo com autenticação
- ✅ Controle de acesso (sem token = 401)
- ✅ Validação de produto duplicado
- ✅ **Testes de Limite**: Preço zero, negativo, quantidade negativa

**Testes Avançados:**
- ✅ **Tipos de Dados**: Rejeita preço como string
- ✅ **Métodos HTTP**: Rejeita POST em rota de detalhe
- ❌ **BUG ENCONTRADO**: API aceita payload gigante (10k caracteres)
- ✅ **Segurança**: XSS, precisão decimal

### 🛒 Módulo Carrinhos (11 testes)
**Endpoints:** `POST /carrinhos`, `DELETE /carrinhos/concluir-compra`, `DELETE /carrinhos/cancelar-compra`

**Testes Básicos:**
- ✅ Fluxo completo: criar → adicionar produto → concluir
- ✅ Cancelamento com restauração de estoque
- ✅ **Integração**: Produto em carrinho não pode ser excluído
- ✅ **Validações**: Produto inexistente, quantidade > estoque
- ✅ **Regra de Negócio**: 1 carrinho por usuário

**Testes Avançados:**
- ✅ **Concorrência**: Simula disputa por último item em estoque
- ✅ **Stress**: Carrinho com 1000 produtos
- ✅ **Segurança**: Token expirado, ID muito longo

---

## ⚙️ Configuração do Ambiente

1. **Clone o repositório:**
   ```bash
   git clone <url-do-repositorio>
   cd challenge-03-serverest
   ```

2. **Instale as dependências:**
   ```bash
   cd robot
   pip install -r requirements.txt
   ```

---

## ▶️ Execução dos Testes

### Execução Completa
```bash
cd robot
python3 -m robot tests/
```

### Execução por Módulo
```bash
# Apenas usuários (9 testes)
python3 -m robot tests/usuarios.robot

# Apenas produtos (11 testes)  
python3 -m robot tests/produtos.robot

# Apenas carrinhos (11 testes)
python3 -m robot tests/carrinhos.robot
```

### Execução por Tags
```bash
# Apenas testes avançados
python3 -m robot --include avancado tests/

# Apenas testes de segurança
python3 -m robot --include seguranca tests/

# Apenas o bug encontrado
python3 -m robot --include BUG tests/
```

---

## 📊 Métricas de Qualidade

### Cobertura de Testes
- **Usuários**: 9 testes (6 básicos + 3 avançados)
- **Produtos**: 11 testes (8 básicos + 3 avançados)
- **Carrinhos**: 11 testes (7 básicos + 4 avançados)
- **Total**: 31 testes automatizados (96% de sucesso - 1 bug encontrado)

### Tipos de Teste Implementados
- ✅ **Testes Positivos** (5): Fluxos de sucesso
- ✅ **Testes Negativos** (16): Validações de erro
- ✅ **Testes de Limite** (5): Bordas das regras de negócio
- ✅ **Testes de Integração** (1): Interação entre módulos
- ✅ **Testes Avançados** (10): Robustez e conformidade REST

### Validações Implementadas
- ✅ **Status Codes HTTP** (200, 201, 400, 401, 404, 405)
- ✅ **Mensagens Específicas** de erro no corpo da resposta
- ✅ **Regras de Negócio** (unicidade, limites, permissões)
- ✅ **Idempotência** (DELETE múltiplas execuções)
- ✅ **Tipos de Dados** (rejeição de tipos incorretos)
- ✅ **Métodos HTTP** (rejeição de verbos inadequados)
- ✅ **Concorrência** (disputa por recursos limitados)
