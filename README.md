# Testes Automatizados - API ServeRest

**Autor:** Gabriel Lucena Ferreira  
**Versão:** 2.0  
**Data:** Outubro 2025

Projeto completo de testes automatizados desenvolvido com Robot Framework para validação da API ServeRest. Este projeto implementa uma suíte robusta de testes que cobre todos os principais módulos da API, incluindo cenários de borda, testes de limite e validações de integração.

## 📋 Sobre o Projeto

A API ServeRest é uma API REST gratuita que simula uma loja virtual, fornecendo endpoints para gerenciamento de usuários, produtos e carrinhos de compra. Este projeto de automação foi desenvolvido para garantir a qualidade e confiabilidade da API através de testes abrangentes.

### Principais Características
- ✅ **Cobertura Completa**: Testa todos os endpoints principais da API
- ✅ **Testes de Limite**: Valida comportamentos nas bordas das regras de negócio
- ✅ **Validação de Mensagens**: Verifica não apenas status codes, mas também conteúdo das respostas
- ✅ **Cenários de Integração**: Testa interações entre diferentes módulos
- ✅ **Evidências Automáticas**: Gera relatórios detalhados com timestamp
- ✅ **Organização Profissional**: Código limpo, documentado e em português

## 🏗️ Arquitetura do Projeto

```
challenge-03-serverest/
├── robot/
│   ├── resources/              # Keywords reutilizáveis
│   │   ├── main.robot         # Configurações principais
│   │   ├── usuarios_keywords.robot    # Keywords para usuários
│   │   ├── produtos_keywords.robot    # Keywords para produtos
│   │   └── carrinhos_keywords.robot   # Keywords para carrinhos
│   ├── tests/                 # Casos de teste
│   │   ├── usuarios.robot     # Testes de usuários
│   │   ├── produtos.robot     # Testes de produtos
│   │   └── carrinhos.robot    # Testes de carrinhos
│   ├── executar_testes.py     # Script de execução
│   ├── requirements.txt       # Dependências
│   └── .gitignore            # Arquivos ignorados
├── plano_de_testes_v2.md     # Plano de testes detalhado
├── GUIA_COMMITS.md           # Guia de organização
└── README.md                 # Este arquivo
```

## 🎯 Funcionalidades Testadas

### 👤 Módulo Usuários
**Endpoints Cobertos:** `POST /usuarios`, `GET /usuarios`, `PUT /usuarios/{id}`, `DELETE /usuarios/{id}`

**Cenários Implementados:**
- ✅ Cadastro de usuário com sucesso
- ✅ Login e geração de token de autenticação
- ✅ Validação de email duplicado
- ✅ **Testes de Limite**: Senhas com 4 (falha), 5 (sucesso) e 10 (sucesso) caracteres
- ✅ Login com credenciais inválidas
- ✅ Exclusão de usuário

### 🛍️ Módulo Produtos
**Endpoints Cobertos:** `POST /produtos`, `GET /produtos`, `PUT /produtos/{id}`, `DELETE /produtos/{id}`

**Cenários Implementados:**
- ✅ Cadastro de produto com autenticação
- ✅ Listagem e busca de produtos
- ✅ **Testes de Limite**: Preço zero (falha), preço negativo (falha)
- ✅ **Testes de Limite**: Quantidade zero (falha)
- ✅ Validação de produto duplicado
- ✅ Tentativa de exclusão sem token (falha)
- ✅ Exclusão de produto com sucesso

### 🛒 Módulo Carrinhos
**Endpoints Cobertos:** `POST /carrinhos`, `GET /carrinhos`, `DELETE /carrinhos/concluir-compra`, `DELETE /carrinhos/cancelar-compra`

**Cenários Implementados:**
- ✅ Criação de carrinho com produtos
- ✅ Conclusão de compra (baixa no estoque)
- ✅ Cancelamento de compra (restauração do estoque)
- ✅ **Cenários de Borda**: Produto inexistente no carrinho
- ✅ **Cenários de Borda**: Quantidade maior que estoque
- ✅ **Cenários de Borda**: Múltiplos carrinhos por usuário (não permitido)
- ✅ **Teste de Integração**: Produto em carrinho não pode ser excluído

## 🚀 Como Executar

### Pré-requisitos
- Python 3.7 ou superior
- pip (gerenciador de pacotes Python)

### Instalação

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

### Execução dos Testes

#### Execução Completa com Evidências (Recomendado)
```bash
cd robot
python executar_testes.py
```

**O que acontece:**
- ✅ Executa todos os testes automaticamente
- ✅ Cria pasta com timestamp para organização
- ✅ Gera relatório HTML detalhado
- ✅ Captura logs completos da execução
- ✅ Cria resumo executivo em markdown

#### Execução Manual (Robot Framework)
```bash
cd robot
robot tests/
```

#### Execução por Módulo
```bash
# Apenas testes de usuários
robot tests/usuarios.robot

# Apenas testes de produtos
robot tests/produtos.robot

# Apenas testes de carrinhos
robot tests/carrinhos.robot
```

#### Execução por Tags
```bash
# Apenas testes positivos
robot --include positivo tests/

# Apenas testes de limite
robot --include limite tests/

# Apenas testes de integração
robot --include integracao tests/
```

## 📊 Interpretando os Resultados

### Arquivos Gerados
Após a execução, você encontrará na pasta `evidencias_YYYYMMDD_HHMMSS/`:

- **`relatorio_execucao.html`** - Relatório principal com resultados visuais
- **`log_detalhado.html`** - Log técnico detalhado de cada teste
- **`resultado_testes.xml`** - Arquivo XML para integração com outras ferramentas
- **`saida_console.txt`** - Saída completa do console
- **`LEIA_ME.md`** - Resumo executivo da execução

### Como Analisar
1. **Abra `relatorio_execucao.html`** no navegador para visão geral
2. **Consulte `log_detalhado.html`** para detalhes técnicos
3. **Verifique `LEIA_ME.md`** para resumo executivo

## 🔧 Tecnologias Utilizadas

- **Robot Framework 6.1.1** - Framework de automação
- **RequestsLibrary 0.9.4** - Biblioteca para requisições HTTP
- **JSONLibrary 0.5** - Biblioteca para manipulação JSON
- **Python 3.x** - Linguagem de programação

## 📈 Métricas de Qualidade

### Cobertura de Testes
- **Usuários**: 5 cenários (positivos, negativos, limite)
- **Produtos**: 6 cenários (CRUD, validações, limite)
- **Carrinhos**: 6 cenários (fluxo completo, integração)
- **Total**: 17+ cenários de teste automatizados

### Tipos de Validação
- ✅ **Status Codes HTTP** - Validação de códigos de resposta
- ✅ **Mensagens de Erro** - Validação de conteúdo específico
- ✅ **Regras de Negócio** - Validação de lógica da aplicação
- ✅ **Integração** - Validação entre módulos

## 🤝 Contribuição

Para contribuir com o projeto:

1. Consulte o `GUIA_COMMITS.md` para padrões de commit
2. Mantenha a documentação atualizada
3. Adicione testes para novas funcionalidades
4. Siga as convenções de nomenclatura em português

## 📝 Documentação Adicional

- **`plano_de_testes_v2.md`** - Plano de testes completo com estratégias
- **`GUIA_COMMITS.md`** - Guia para organização de commits
- **API ServeRest**: https://serverest.dev

---

**Desenvolvido com foco em qualidade, organização e boas práticas de automação de testes.**