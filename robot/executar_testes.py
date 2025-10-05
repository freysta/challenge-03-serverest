#!/usr/bin/env python3
"""
Script para executar testes Robot Framework com geração de evidências
Autor: Gabriel Lucena Ferreira
Data: Outubro 2025
"""

import os
import subprocess
import datetime
from pathlib import Path

def criar_pasta_evidencias():
    """Cria pasta para evidências com timestamp"""
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    pasta_evidencias = Path(f"evidencias_{timestamp}")
    pasta_evidencias.mkdir(exist_ok=True)
    return pasta_evidencias

def executar_testes_robot(pasta_evidencias):
    """Executa os testes Robot Framework com relatórios em português"""
    
    argumentos_robot = [
        "robot",
        "--outputdir", str(pasta_evidencias),
        "--report", "relatorio_execucao.html",
        "--log", "log_detalhado.html", 
        "--output", "resultado_testes.xml",
        "--loglevel", "INFO",
        "--name", "Testes API ServeRest",
        "--doc", "Execução automatizada dos testes da API ServeRest",
        "tests/"
    ]
    
    print("🤖 Iniciando execução dos testes automatizados...")
    print(f"📁 Evidências serão salvas em: {pasta_evidencias}")
    
    try:
        resultado = subprocess.run(argumentos_robot, capture_output=True, text=True)
        
        # Salva saída do console
        with open(pasta_evidencias / "saida_console.txt", "w", encoding="utf-8") as arquivo:
            arquivo.write("=== SAÍDA PADRÃO ===\n")
            arquivo.write(resultado.stdout)
            arquivo.write("\n\n=== SAÍDA DE ERRO ===\n") 
            arquivo.write(resultado.stderr)
        
        print(f"✅ Execução finalizada! Código de retorno: {resultado.returncode}")
        return resultado.returncode == 0
        
    except Exception as erro:
        print(f"❌ Erro durante a execução: {erro}")
        return False

def gerar_relatorio_resumo(pasta_evidencias):
    """Gera relatório resumo em português"""
    conteudo_resumo = f"""
# Relatório de Execução - Testes API ServeRest

**Data da Execução:** {datetime.datetime.now().strftime("%d/%m/%Y às %H:%M:%S")}
**Autor:** Gabriel Lucena Ferreira


## 📁 Arquivos Gerados

- `relatorio_execucao.html` - Relatório principal com resultados detalhados
- `log_detalhado.html` - Log completo da execução dos testes
- `resultado_testes.xml` - Arquivo XML para integração com outras ferramentas
- `saida_console.txt` - Saída completa do console durante execução

## 🎯 Módulos Testados

### ✅ Usuários
- Cadastro, login e exclusão
- Testes de limite para senhas (4, 5, 10 caracteres)
- Validação de emails duplicados
- Validação de mensagens de erro

### ✅ Produtos  
- CRUD completo com autenticação
- Testes de limite para preços e quantidades
- Validação de produtos duplicados
- Controle de acesso via token

### ✅ Carrinhos
- Fluxo completo de compras
- Cenários de integração com produtos
- Validação de regras de negócio
- Cancelamento e conclusão de compras

## 🔍 Tipos de Teste Executados

- 🎯 **Testes Funcionais** - Validação de funcionalidades principais
- 🔒 **Testes de Segurança** - Controle de acesso e autenticação  
- ⚠️ **Testes Negativos** - Validação de cenários de erro
- 🔄 **Testes de Integração** - Interação entre módulos
- 📏 **Testes de Limite** - Valores nas bordas das regras

## 📊 Como Visualizar os Resultados

1. Abra o arquivo `relatorio_execucao.html` no seu navegador
2. Para detalhes técnicos, consulte `log_detalhado.html`
3. Para integração, utilize o arquivo `resultado_testes.xml`

---
*Relatório gerado automaticamente pelo script de execução*
"""
    
    with open(pasta_evidencias / "LEIA_ME.md", "w", encoding="utf-8") as arquivo:
        arquivo.write(conteudo_resumo)

def main():
    """Função principal do script"""
    print("🚀 Script de Execução - Testes API ServeRest")
    print("=" * 55)
    
    # Navega para o diretório correto
    os.chdir(Path(__file__).parent)
    
    # Cria pasta para evidências
    pasta_evidencias = criar_pasta_evidencias()
    
    # Executa os testes
    sucesso = executar_testes_robot(pasta_evidencias)
    
    # Gera relatório resumo
    gerar_relatorio_resumo(pasta_evidencias)
    
    print("\n" + "=" * 55)
    if sucesso:
        print("✅ Testes executados com sucesso!")
    else:
        print("⚠️ Alguns testes falharam - verifique o relatório")
    
    print(f"📋 Evidências salvas em: {pasta_evidencias.absolute()}")
    print("💡 Abra 'relatorio_execucao.html' para ver os resultados")

if __name__ == "__main__":
    main()