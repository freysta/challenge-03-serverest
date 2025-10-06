# Guia de Commits - Projeto ServeRest

## 📋 Estrutura de Commits Sugerida

### Etapa 1: Configuração Inicial
```bash
git add robot/requirements.txt robot/.gitignore
git commit -m "feat: configuração inicial do projeto Robot Framework

- Adiciona dependências do Robot Framework
- Configura .gitignore para arquivos de resultado
- Estabelece base para testes automatizados"
```

### Etapa 2: Keywords de Usuários
```bash
git add robot/resources/usuarios_keywords.robot
git commit -m "feat: implementa keywords para testes de usuários

- Adiciona cadastro, login e exclusão de usuários
- Implementa testes de limite para senhas (4, 5, 10 chars)
- Inclui validação de mensagens de erro específicas
- Traduz variáveis e comentários para português"
```

### Etapa 3: Keywords de Produtos  
```bash
git add robot/resources/produtos_keywords.robot
git commit -m "feat: implementa keywords para testes de produtos

- Adiciona CRUD completo de produtos com autenticação
- Implementa testes de limite para preços e quantidades
- Inclui validação de produtos duplicados
- Adiciona controle de acesso via token"
```

### Etapa 4: Keywords de Carrinhos
```bash
git add robot/resources/carrinhos_keywords.robot  
git commit -m "feat: implementa keywords para testes de carrinhos

- Adiciona fluxo completo de carrinhos de compra
- Implementa cenários de integração com produtos
- Inclui cancelamento e conclusão de compras
- Adiciona validação de regras de negócio específicas"
```

### Etapa 5: Arquivo Principal
```bash
git add robot/resources/main.robot
git commit -m "feat: configura arquivo principal de recursos

- Centraliza configuração da URL base
- Estabelece conexão com API ServeRest
- Importa todos os recursos necessários
- Adiciona documentação em português"
```

### Etapa 6: Casos de Teste
```bash
git add robot/tests/
git commit -m "feat: implementa casos de teste automatizados

- Adiciona testes para usuários, produtos e carrinhos
- Inclui cenários positivos, negativos e de limite
- Implementa testes de integração entre módulos
- Adiciona tags e documentação para organização"
```

### Etapa 7: Scripts de Execução
```bash
git add robot/executar_testes.py COMO_EXECUTAR.md
git commit -m "feat: adiciona scripts de execução e documentação

- Cria script Python para execução com evidências
- Gera relatórios HTML detalhados automaticamente
- Inclui documentação completa de execução
- Implementa captura de logs e timestamps"
```

### Etapa 8: Documentação Final
```bash
git add plano_de_testes_v2.md GUIA_COMMITS.md
git commit -m "docs: atualiza documentação do projeto

- Atualiza plano de testes com melhorias implementadas
- Adiciona guia de commits para organização
- Documenta todos os cenários implementados
- Inclui evidências de execução no plano"
```

## 🏷️ Convenção de Tags

### Tipos de Commit
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `test:` - Testes
- `refactor:` - Refatoração
- `style:` - Formatação

### Exemplos de Boas Práticas
```bash
# ✅ Bom
git commit -m "feat: adiciona validação de senha mínima

- Implementa teste para senha com 4 caracteres
- Valida mensagem de erro específica da API
- Adiciona documentação do cenário de teste"

# ❌ Evitar  
git commit -m "mudanças nos testes"
```

## 📊 Fluxo de Trabalho Sugerido

1. **Desenvolver** uma funcionalidade por vez
2. **Testar** localmente antes do commit
3. **Documentar** as mudanças no commit
4. **Organizar** commits por etapas lógicas
5. **Revisar** antes de fazer push

## 🔍 Checklist Antes do Commit

- [ ] Código testado localmente
- [ ] Mensagem de commit descritiva
- [ ] Arquivos relacionados agrupados
- [ ] Documentação atualizada se necessário
- [ ] Sem arquivos desnecessários (logs, cache)

---
*Guia criado para organizar o desenvolvimento do projeto ServeRest*