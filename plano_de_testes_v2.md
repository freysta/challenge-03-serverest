# Plano de Testes v2.0 - API ServeRest

**Data:** 01/10/2025
**Autor:** Gabriel Lucena Ferreira

## 1. Apresentação

Este plano de testes serve como um guia estratégico para a validação da API ServeRest. Esta versão (v2.0) incorpora os feedbacks recebidos no Challenge anterior e expande o escopo para incluir o módulo de Carrinhos, com foco em testes de limite e cenários de borda.

## 2. Objetivo

O objetivo primário é assegurar que a API ServeRest atenda integralmente aos critérios de aceitação, garantindo a entrega de um produto com alta qualidade, resiliência e segurança.

## 3. Escopo

#### Funcionalidades em Escopo
- **User Story 001 - Usuários:** Validação completa do ciclo de vida (CRUD) e regras de negócio.
- **User Story 002 - Login:** Verificação do processo de autenticação e geração de token.
- **User Story 003 - Produtos:** Testes de todas as operações CRUD, com ênfase no controle de acesso via token.
- **User Story 004 - Carrinhos:** Validação completa do fluxo de carrinhos de compra, incluindo a criação, exclusão e conclusão de compra, bem como sua integração com os módulos de Produtos e Usuários.

#### Funcionalidades Fora de Escopo
- Testes de performance, carga ou estresse.

## 4. Análise Estratégica e Pontos de Atenção

- **Dependência de Fluxo:** A ordem lógica (Usuário -> Login -> Token -> Produtos/Carrinhos) é mantida e reforçada na automação.
- **Cenários de Borda e Integração (Feedback Aplicado):** Foi adicionado um foco especial em cenários que integram diferentes módulos. O principal caso de teste é a tentativa de exclusão de um produto que já está associado a um carrinho de compras, onde a API deve impedir a ação e retornar uma mensagem de erro clara.
- **Validação de Mensagens de Erro (Feedback Aplicado):** A estratégia agora torna obrigatório que todos os testes negativos validem não apenas o `status code` HTTP, mas também a `mensagem` específica de erro retornada no corpo da resposta, garantindo consistência e clareza para os consumidores da API.

## 5. Técnicas Aplicadas

- **Teste Funcional:** Validação de cada endpoint.
- **Teste de Segurança:** Verificação de acesso a rotas protegidas.
- **Teste Negativo:** Foco em respostas de erro consistentes.
- **Análise de Valor Limite (Feedback Aplicado):** Foco nos limites das regras de negócio. Além das senhas, agora incluímos testes para `preco` e `quantidade` de produtos (valores negativos, zero e positivos).

## 6. Cenários de Teste Planejados

#### Módulo: Login (User Story 002)
- `POST /login`: Sucesso, falha por senha incorreta, falha por usuário inexistente.

#### Módulo: Usuários (User Story 001)
- `POST /usuarios`: Sucesso; falha por e-mail duplicado; falha por senha com 4, 5, 10 e 11 caracteres.
- `GET /usuarios`: Listagem geral; busca por ID existente e inexistente.
- `PUT /usuarios/{_id}`: Atualização com sucesso; falha ao usar e-mail já existente.
- `DELETE /usuarios/{_id}`: Exclusão com sucesso e falha ao tentar excluir usuário inexistente.

#### Módulo: Produtos (User Story 003)
- `POST /produtos`: Sucesso com token válido; falha por falta de token; falha por nome duplicado.
- `GET /produtos`: Listagem geral; busca por ID existente e inexistente.
- `PUT /produtos/{_id}`: Atualização com sucesso.
- `DELETE /produtos/{_id}`: Exclusão com sucesso.

#### Módulo: Carrinhos (User Story 004) - NOVO
- `GET /carrinhos`: Listagem com sucesso; busca por ID existente e inexistente.
- `POST /carrinhos`: Criação de carrinho com sucesso.
- `DELETE /carrinhos/concluir-compra`: Sucesso na conclusão, com verificação de baixa de estoque do produto.
- `DELETE /carrinhos/cancelar-compra`: Sucesso no cancelamento, com verificação de restauração de estoque.
- **Teste de Integração:** Tentar excluir um produto que está em um carrinho e validar a mensagem de erro.

## 7. Testes Candidatos à Automação
- **Suíte de Fumaça (Smoke Test):** Fluxo completo: Criar Usuário -> Login -> Criar Produto -> Criar Carrinho -> Concluir Compra -> Excluir Usuário.
- **Regressão de Regras de Negócio:** Todos os testes que validam unicidade (usuário/produto), limites (senha/preço) e segurança (acesso com/sem token).
- **Regressão de Integração:** Cenários que envolvem múltiplos módulos, como o fluxo de carrinhos.
