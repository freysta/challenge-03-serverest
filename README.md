# Challenge 03: Automação da API ServeRest com Robot Framework

Este repositório contém a solução para o Challenge 03, que consiste em uma suíte de testes automatizados para a API ServeRest, utilizando Robot Framework. O projeto abrange planejamento, execução manual, automação de regressão e configuração de ambiente.

---

## 🚀 Tecnologias Utilizadas

* **Linguagem:** Python 3.x
* **Framework de Automação:** Robot Framework
* **Bibliotecas Principais:**
    * `RequestsLibrary`: Para realizar as requisições HTTP.
    * `JSONLibrary`: Para validar os corpos das respostas JSON.
    * `Faker`: Para geração de dados dinâmicos.
* **Gerenciador de Pacotes:** Pip com `requirements.txt`.
* **Controle de Versão:** Git e GitHub.

---

## 📂 Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
/robot
|-- /resources
|   |-- base.resource
|   |-- users.resource
|   |-- login.resource
|   |-- products.resource
|   `-- carts.resource
|-- /tests
|   |-- /users
|   |-- /login
|   |-- /products
|   `-- /carts
|-- /variables
|   |-- config.py
|   `-- payloads.py
|-- /utils
|   `-- helpers.py
`-- requirements.txt
```

---

## ⚙️ Configuração do Ambiente

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/challenge-03-serverest.git
   cd challenge-03-serverest
   ```

2. **Instale as dependências:**
   ```bash
   pip install -r robot/requirements.txt
   ```

---

## ▶️ Execução dos Testes

Para executar os testes, utilize o comando `robot` a partir da raiz do projeto:

* **Executar todos os testes:**
  ```bash
  robot -d robot/reports robot/tests
  ```

* **Executar um módulo específico (ex: usuários):**
  ```bash
  robot -d robot/reports robot/tests/users
  ```

* **Executar por tag (ex: smoke):**
  ```bash
  robot -d robot/reports -i smoke robot/tests
  ```

---

## 📄 Relatórios

Os relatórios de execução são gerados na pasta `robot/reports` e incluem:

* `report.html`: Relatório visual detalhado com os resultados dos testes.
* `log.html`: Log completo da execução.
* `output.xml`: Arquivo XML para integração com ferramentas de CI/CD.
