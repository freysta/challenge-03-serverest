# Challenge 03: Automação da API ServeRest com Robot Framework

**Autor:** Gabriel Lucena Ferreira  
**Versão:** 3.0  
**Data:** Outubro 2025

Este repositório contém a solução completa para o Challenge 03, implementando **21 testes automatizados** para a API ServeRest com Robot Framework. O projeto vai além dos testes funcionais básicos, incluindo testes avançados de robustez, idempotência e conformidade REST.

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
│   │   ├── usuarios.robot     # 6 testes de usuários
│   │   ├── produtos.robot     # 8 testes de produtos
│   │   └── carrinhos.robot    # 7 testes de carrinhos
│   └── requirements.txt       # Dependências
├── plano_de_testes_v2.md     # Plano de testes detalhado
├── GUIA_COMMITS.md           # Guia de organização
└── README.md                 # Este arquivo
```

---

## 🎯 Funcionalidades Testadas (21 Testes)

### 👤 Módulo Usuários (6 testes)
**Endpoints:** `POST /usuarios`, `GET /usuarios`, `DELETE /usuarios/{id}`, `POST /login`

**Testes Básicos:**
- ✅ Cadastro, login e exclusão (fluxo completo)
- ✅ Email duplicado (validação de unicidade)
- ✅ Senha vazia (validação de limite)
- ✅ Login com credenciais inválidas

**Testes Avançados:**
- ✅ **Idempotência**: DELETE pode ser executado múltiplas vezes
- ✅ **Listagem**: Validação da API de listagem

### 🛍️ Módulo Produtos (8 testes)
**Endpoints:** `POST /produtos`, `GET /produtos`, `DELETE /produtos/{id}`

**Testes Básicos:**
- ✅ CRUD completo com autenticação
- ✅ Controle de acesso (sem token = 401)
- ✅ Validação de produto duplicado
- ✅ **Testes de Limite**: Preço zero, negativo, quantidade negativa

**Testes Avançados:**
- ✅ **Tipos de Dados**: Rejeita preço como string
- ✅ **Métodos HTTP**: Rejeita POST em rota de detalhe

### 🛒 Módulo Carrinhos (7 testes)
**Endpoints:** `POST /carrinhos`, `DELETE /carrinhos/concluir-compra`, `DELETE /carrinhos/cancelar-compra`

**Testes Básicos:**
- ✅ Fluxo completo: criar → adicionar produto → concluir
- ✅ Cancelamento com restauração de estoque
- ✅ **Integração**: Produto em carrinho não pode ser excluído
- ✅ **Validações**: Produto inexistente, quantidade > estoque
- ✅ **Regra de Negócio**: 1 carrinho por usuário

**Testes Avançados:**
- ✅ **Concorrência**: Simula disputa por último item em estoque

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
# Apenas usuários (6 testes)
python3 -m robot tests/usuarios.robot

# Apenas produtos (8 testes)  
python3 -m robot tests/produtos.robot

# Apenas carrinhos (7 testes)
python3 -m robot tests/carrinhos.robot
```

### Execução por Tags
```bash
# Apenas testes avançados
python3 -m robot --include avancado tests/

# Apenas testes de limite
python3 -m robot --include limite tests/

# Apenas testes positivos
python3 -m robot --include positivo tests/
```

---

## 📊 Métricas de Qualidade

### Cobertura de Testes
- **Usuários**: 6 testes (4 básicos + 2 avançados)
- **Produtos**: 8 testes (6 básicos + 2 avançados)
- **Carrinhos**: 7 testes (6 básicos + 1 avançado)
- **Total**: 21 testes automatizados (100% de sucesso)

### Tipos de Teste Implementados
- ✅ **Testes Positivos** (5): Fluxos de sucesso
- ✅ **Testes Negativos** (11): Validações de erro
- ✅ **Testes de Limite** (3): Bordas das regras de negócio
- ✅ **Testes de Integração** (1): Interação entre módulos
- ✅ **Testes Avançados** (5): Robustez e conformidade REST

### Validações Implementadas
- ✅ **Status Codes HTTP** (200, 201, 400, 401, 404, 405)
- ✅ **Mensagens Específicas** de erro no corpo da resposta
- ✅ **Regras de Negócio** (unicidade, limites, permissões)
- ✅ **Idempotência** (DELETE múltiplas execuções)
- ✅ **Tipos de Dados** (rejeição de tipos incorretos)
- ✅ **Métodos HTTP** (rejeição de verbos inadequados)
- ✅ **Concorrência** (disputa por recursos limitados)

---

## 📄 Relatórios

Os relatórios são gerados automaticamente na pasta raiz:

* `report.html`: Relatório visual com resultados detalhados
* `log.html`: Log completo da execução
* `output.xml`: Arquivo XML para integração CI/CD

---

## 🏆 Diferenciais do Projeto

### Testes Avançados Implementados
1. **Idempotência**: Valida que operações DELETE podem ser repetidas
2. **Tipos de Dados**: Testa rejeição de tipos incorretos (string no lugar de number)
3. **Métodos HTTP**: Valida rejeição de verbos inadequados para cada rota
4. **Concorrência**: Simula cenários de disputa por recursos limitados
5. **Listagem**: Valida endpoints de consulta e suas respostas

### Qualidade e Organização
- ✅ **Estrutura Profissional**: Separação clara entre testes e lógica
- ✅ **Testes Independentes**: Cada teste pode ser executado isoladamente
- ✅ **Validação Dupla**: Status code + mensagem específica
- ✅ **Versionamento**: Uso de branches para desenvolvimento
- ✅ **Documentação**: Código autodocumentado com tags explicativas

---

## 📝 Documentação Adicional

- **`plano_de_testes_v2.md`** - Plano de testes completo com estratégias
- **`GUIA_COMMITS.md`** - Guia para organização de commits
- **API ServeRest**: https://compassuol.serverest.dev/

---

**Projeto desenvolvido seguindo as melhores práticas de automação de testes e conformidade REST.**