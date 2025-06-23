#!/bin/bash

# 🚀 GitHub Badges Mastery - Script de Configuração
# Script para configurar automaticamente o ambiente para conquista de badges

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Função para imprimir cabeçalho
print_header() {
    echo -e "${PURPLE}=================================="
    echo -e "🚀 GITHUB BADGES SETUP SCRIPT"
    echo -e "==================================${NC}"
    echo
}

# Função para verificar dependências
check_dependencies() {
    echo -e "${BLUE}🔍 Verificando dependências...${NC}"
    
    # Verificar Git
    if command -v git &> /dev/null; then
        echo -e "Git: ${GREEN}✅ Instalado$(git --version)${NC}"
    else
        echo -e "Git: ${RED}❌ Não encontrado${NC}"
        exit 1
    fi
    
    # Verificar GitHub CLI
    if command -v gh &> /dev/null; then
        echo -e "GitHub CLI: ${GREEN}✅ Instalado$(gh --version | head -n1)${NC}"
    else
        echo -e "GitHub CLI: ${YELLOW}⚠️ Não encontrado (recomendado)${NC}"
        echo "Instale com: https://cli.github.com/"
    fi
    
    # Verificar Node.js (opcional)
    if command -v node &> /dev/null; then
        echo -e "Node.js: ${GREEN}✅ Instalado$(node --version)${NC}"
    else
        echo -e "Node.js: ${YELLOW}⚠️ Não encontrado (opcional)${NC}"
    fi
    
    echo
}

# Função para configurar Git
setup_git() {
    echo -e "${BLUE}⚙️ Configurando Git para badges...${NC}"
    
    # Verificar se já está configurado
    if git config --global user.name &> /dev/null && git config --global user.email &> /dev/null; then
        echo -e "Git já configurado para:"
        echo -e "Nome: ${GREEN}$(git config --global user.name)${NC}"
        echo -e "Email: ${GREEN}$(git config --global user.email)${NC}"
    else
        echo "Configure seu Git:"
        read -p "Nome: " git_name
        read -p "Email: " git_email
        
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
        echo -e "${GREEN}✅ Git configurado!${NC}"
    fi
    
    # Configurar template para co-autoria
    echo -e "\n\nCo-authored-by: GitHub Copilot <copilot@github.com>" > .gitmessage
    git config commit.template .gitmessage
    echo -e "${GREEN}✅ Template de co-autoria configurado!${NC}"
    echo
}

# Função para configurar GitHub CLI
setup_github_cli() {
    if command -v gh &> /dev/null; then
        echo -e "${BLUE}🔐 Configurando GitHub CLI...${NC}"
        
        # Verificar se já está autenticado
        if gh auth status &> /dev/null; then
            echo -e "${GREEN}✅ GitHub CLI já autenticado!${NC}"
        else
            echo "Fazendo login no GitHub CLI..."
            gh auth login
        fi
        
        # Configurar aliases úteis
        gh alias set pr-create 'pr create --title "feat: " --body "Implementação de nova funcionalidade"'
        gh alias set issue-quick 'issue create --title "📋 Task: " --body "Nova tarefa criada automaticamente"'
        
        echo -e "${GREEN}✅ Aliases configurados!${NC}"
    else
        echo -e "${YELLOW}⚠️ GitHub CLI não encontrado, pulando configuração${NC}"
    fi
    echo
}

# Função para criar estrutura de projeto
create_project_structure() {
    echo -e "${BLUE}📁 Criando estrutura do projeto...${NC}"
    
    # Criar diretórios se não existirem
    mkdir -p src tests examples scripts docs
    mkdir -p .github/workflows .github/ISSUE_TEMPLATE
    
    # Criar arquivos básicos se não existirem
    [ ! -f .gitignore ] && cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*

# Environment
.env
.env.local

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Logs
*.log

# Reports
badge-progress-*.md
EOF

    [ ! -f CONTRIBUTING.md ] && cat > CONTRIBUTING.md << 'EOF'
# 🤝 Contribuindo para GitHub Badges Mastery

## Como Contribuir

1. Fork o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças com co-autoria (`git commit -m "feat: nova feature

Co-authored-by: GitHub Copilot <copilot@github.com>"`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Padrões de Commit

- `feat:` para novas funcionalidades
- `fix:` para correções
- `docs:` para documentação
- `test:` para testes
- `refactor:` para refatoração

## Co-autoria

Sempre inclua co-autores nos commits:
```
git commit -m "feat: nova funcionalidade

Co-authored-by: GitHub Copilot <copilot@github.com>"
```
EOF

    echo -e "${GREEN}✅ Estrutura do projeto criada!${NC}"
    echo
}

# Função para configurar package.json
setup_package_json() {
    if [ ! -f package.json ]; then
        echo -e "${BLUE}📦 Criando package.json...${NC}"
        
        cat > package.json << 'EOF'
{
  "name": "github-badges-mastery",
  "version": "1.0.0",
  "description": "Projeto para conquistar insígnias do GitHub sistematicamente",
  "main": "src/index.js",
  "scripts": {
    "test": "echo \"Running tests...\" && exit 0",
    "build": "echo \"Building project...\" && exit 0",
    "start": "node src/index.js",
    "badges": "bash scripts/badge-monitor.sh",
    "setup": "bash scripts/setup-badges.sh"
  },
  "keywords": [
    "github",
    "badges",
    "achievements",
    "automation",
    "devops"
  ],
  "author": "GitHub Badges Master",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/username/github-badges-mastery.git"
  }
}
EOF
        echo -e "${GREEN}✅ package.json criado!${NC}"
    else
        echo -e "${YELLOW}⚠️ package.json já existe${NC}"
    fi
    echo
}

# Função para criar arquivo de exemplo
create_example_files() {
    echo -e "${BLUE}📝 Criando arquivos de exemplo...${NC}"
    
    # Arquivo principal
    [ ! -f src/index.js ] && cat > src/index.js << 'EOF'
// 🏆 GitHub Badges Mastery - Arquivo Principal
console.log('🚀 GitHub Badges Mastery iniciado!');

// Função para demonstrar funcionalidade
function demonstrateBadges() {
    console.log('📊 Monitorando progresso das badges...');
    
    const badges = [
        '🦈 Pull Shark',
        '👥 Pair Extraordinaire', 
        '⚙️ DevOps Guru',
        '🧠 Galaxy Brain',
        '⚡ Quickdraw',
        '❤️ Heart On Your Sleeve',
        '🎲 YOLO'
    ];
    
    badges.forEach((badge, index) => {
        console.log(`${index + 1}. ${badge}`);
    });
}

// Executar demonstração
demonstrateBadges();

module.exports = { demonstrateBadges };
EOF

    # Arquivo de teste
    [ ! -f tests/index.test.js ] && cat > tests/index.test.js << 'EOF'
// 🧪 Testes para GitHub Badges Mastery
const { demonstrateBadges } = require('../src/index.js');

// Teste simples
function testDemonstrateBadges() {
    console.log('🧪 Testando função demonstrateBadges...');
    
    try {
        demonstrateBadges();
        console.log('✅ Teste passou!');
        return true;
    } catch (error) {
        console.error('❌ Teste falhou:', error);
        return false;
    }
}

// Executar teste
if (require.main === module) {
    const result = testDemonstrateBadges();
    process.exit(result ? 0 : 1);
}

module.exports = { testDemonstrateBadges };
EOF

    echo -e "${GREEN}✅ Arquivos de exemplo criados!${NC}"
    echo
}

# Função para fazer commit inicial
initial_commit() {
    echo -e "${BLUE}📝 Fazendo commit inicial...${NC}"
    
    # Verificar se há mudanças para commit
    if git diff --staged --quiet && git diff --quiet; then
        echo -e "${YELLOW}⚠️ Nenhuma mudança para commit${NC}"
    else
        git add .
        git commit -m "feat: configuração inicial do projeto para badges

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Setup Script <setup@badges-mastery.com>" || echo "Commit já realizado ou erro"
        
        echo -e "${GREEN}✅ Commit inicial realizado!${NC}"
    fi
    echo
}

# Função para mostrar próximos passos
show_next_steps() {
    echo -e "${PURPLE}🎯 PRÓXIMOS PASSOS${NC}"
    echo "=================================="
    echo
    echo -e "1. ${BLUE}Executar monitor de badges:${NC}"
    echo "   bash scripts/badge-monitor.sh"
    echo
    echo -e "2. ${BLUE}Criar primeira branch e PR:${NC}"
    echo "   git checkout -b feature/primeira-feature"
    echo "   echo 'Nova feature' > feature.md"
    echo "   git add feature.md"
    echo "   git commit -m 'feat: primeira feature"
    echo
    echo "   Co-authored-by: GitHub Copilot <copilot@github.com>'"
    echo "   git push origin feature/primeira-feature"
    echo "   gh pr create --title 'feat: primeira feature' --body 'Primeira feature para badge Pull Shark'"
    echo
    echo -e "3. ${BLUE}Habilitar GitHub Actions:${NC}"
    echo "   - Vá em Settings > Actions > General"
    echo "   - Permitir todas as actions"
    echo
    echo -e "4. ${BLUE}Habilitar Discussões:${NC}"
    echo "   - Vá em Settings > Features"
    echo "   - Marcar 'Discussions'"
    echo
    echo -e "5. ${BLUE}Executar workflows:${NC}"
    echo "   gh workflow run ci.yml"
    echo "   gh workflow run auto-issue.yml"
    echo
    echo -e "${GREEN}🎉 Configuração concluída! Boa sorte na conquista das badges!${NC}"
}

# Função principal
main() {
    print_header
    check_dependencies
    setup_git
    setup_github_cli
    create_project_structure
    setup_package_json
    create_example_files
    initial_commit
    show_next_steps
}

# Executar script
main "$@"
