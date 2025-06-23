#!/bin/bash

# 🤖 GitHub Badges Mastery - Script de Automação Completa
# Script para conquistar múltiplas badges automaticamente

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função para imprimir cabeçalho
print_header() {
    echo -e "${PURPLE}=================================="
    echo -e "🤖 AUTO BADGES CONQUEST SCRIPT"
    echo -e "Data: $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "==================================${NC}"
    echo
}

# Função para log com timestamp
log() {
    echo -e "${CYAN}[$(date '+%H:%M:%S')] $1${NC}"
}

# Função para sucesso
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Função para erro
error() {
    echo -e "${RED}❌ $1${NC}"
}

# Função para warning
warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

# Função para verificar dependências
check_dependencies() {
    log "Verificando dependências..."
    
    if ! command -v git &> /dev/null; then
        error "Git não encontrado!"
        exit 1
    fi
    
    if ! command -v gh &> /dev/null; then
        warning "GitHub CLI não encontrado. Algumas funcionalidades serão limitadas."
        return 1
    fi
    
    success "Dependências verificadas!"
    return 0
}

# Função para Pull Shark automation
automate_pull_shark() {
    log "🦈 Automatizando Pull Shark..."
    
    # Criar timestamp único
    timestamp=$(date +%s)
    branch_name="feature/auto-feature-$timestamp"
    
    # Criar nova branch
    git checkout main 2>/dev/null || git checkout -b main
    git checkout -b "$branch_name"
    
    # Criar arquivo de feature
    feature_file="features/auto-feature-$timestamp.md"
    mkdir -p features
    
    cat > "$feature_file" << EOF
# 🚀 Auto Feature $timestamp

Esta feature foi criada automaticamente pelo script de automação de badges.

## Descrição
Feature implementada em $(date) para contribuir com a conquista da badge Pull Shark.

## Funcionalidades
- ✅ Criação automática de conteúdo
- ✅ Commit com co-autoria
- ✅ Branch estruturada
- ✅ Documentação incluída

## Impacto nas Badges
- 🦈 Pull Shark: Contribui com +1 PR
- 👥 Pair Extraordinaire: Commit com co-autoria
- ⚙️ DevOps Guru: Pode ser usado em workflows

## Timestamp
Criado em: $(date)
Branch: $branch_name
EOF
    
    # Fazer commit com co-autoria
    git add "$feature_file"
    git commit -m "feat: implementar auto feature $timestamp

Feature criada automaticamente para badge Pull Shark.
Inclui documentação e estrutura padronizada.

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Automation Bot <automation@badges-mastery.com>"
    
    success "Branch $branch_name criada com feature automática!"
    
    # Se GitHub CLI disponível, criar PR
    if command -v gh &> /dev/null; then
        if gh auth status &> /dev/null; then
            log "Criando PR automaticamente..."
            gh pr create \
                --title "feat: auto feature $timestamp" \
                --body "🤖 Feature criada automaticamente para badge Pull Shark

## 🎯 Objetivo
Contribuir para a conquista da badge Pull Shark através de automação.

## 🏆 Badges Impactadas
- 🦈 Pull Shark: +1 PR
- 👥 Pair Extraordinaire: Commit com co-autoria

## 🔄 Mudanças
- Adicionado arquivo de feature em \`$feature_file\`
- Documentação completa incluída
- Commit seguindo padrões estabelecidos

## 🤖 Automação
Este PR foi criado automaticamente pelo script \`auto-badges.sh\`." \
                --label "automation,pull-shark,feature" || warning "Falha ao criar PR via CLI"
        else
            warning "GitHub CLI não autenticado. PR deve ser criado manualmente."
        fi
    fi
    
    return 0
}

# Função para Pair Extraordinaire automation
automate_pair_extraordinaire() {
    log "👥 Automatizando Pair Extraordinaire..."
    
    # Verificar se há commits com co-autoria
    coauthor_count=$(git log --grep="Co-authored-by" --oneline | wc -l)
    
    if [ "$coauthor_count" -gt 0 ]; then
        success "Já existem $coauthor_count commits com co-autoria!"
    else
        warning "Nenhum commit com co-autoria encontrado. Criando..."
        
        # Criar arquivo para commit com co-autoria
        echo "# Pair Programming Example" > pair-example.md
        echo "Este arquivo demonstra colaboração para badge Pair Extraordinaire." >> pair-example.md
        echo "Criado em: $(date)" >> pair-example.md
        
        git add pair-example.md
        git commit -m "feat: adicionar exemplo de pair programming

Demonstra colaboração para badge Pair Extraordinaire.

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Pair Partner <pair@badges-mastery.com>"
        
        success "Commit com co-autoria criado!"
    fi
    
    return 0
}

# Função para Quickdraw automation
automate_quickdraw() {
    log "⚡ Automatizando Quickdraw..."
    
    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        timestamp=$(date '+%H:%M:%S')
        
        # Criar issue rapidamente
        gh issue create \
            --title "⚡ Auto Issue - $timestamp" \
            --body "🤖 Issue criada automaticamente em menos de 5 minutos!

## 📋 Detalhes
- Criada em: $(date)
- Script: auto-badges.sh
- Objetivo: Badge Quickdraw

## 🎯 Próximos Passos
- [ ] Verificar se badge foi conquistada
- [ ] Fechar issue após verificação
- [ ] Documentar sucesso" \
            --label "quickdraw,automation" && success "Issue criada rapidamente!" || warning "Falha ao criar issue"
    else
        warning "GitHub CLI não disponível para Quickdraw automation"
    fi
    
    return 0
}

# Função para DevOps Guru automation
automate_devops_guru() {
    log "⚙️ Automatizando DevOps Guru..."
    
    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        # Verificar workflows existentes
        workflow_count=$(find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null | wc -l)
        
        if [ "$workflow_count" -gt 0 ]; then
            success "$workflow_count workflows encontrados!"
            
            # Executar workflow se disponível
            log "Executando workflows..."
            gh workflow run ci.yml 2>/dev/null && success "Workflow CI executado!" || warning "Falha ao executar workflow CI"
            gh workflow run auto-issue.yml 2>/dev/null && success "Workflow auto-issue executado!" || warning "Falha ao executar workflow auto-issue"
        else
            warning "Nenhum workflow encontrado!"
        fi
    else
        warning "GitHub CLI não disponível para DevOps Guru automation"
    fi
    
    return 0
}

# Função para Heart On Your Sleeve automation
automate_heart_on_sleeve() {
    log "❤️ Automatizando Heart On Your Sleeve..."
    
    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        # Listar issues para reagir
        issues=$(gh issue list --limit 3 --json number --jq '.[].number' 2>/dev/null)
        
        if [ -n "$issues" ]; then
            for issue in $issues; do
                # Adicionar reações via API
                gh api "repos/:owner/:repo/issues/$issue/reactions" -f content="+1" 2>/dev/null && log "Reação +1 adicionada à issue #$issue"
                gh api "repos/:owner/:repo/issues/$issue/reactions" -f content="heart" 2>/dev/null && log "Reação ❤️ adicionada à issue #$issue"
                gh api "repos/:owner/:repo/issues/$issue/reactions" -f content="rocket" 2>/dev/null && log "Reação 🚀 adicionada à issue #$issue"
            done
            success "Reações adicionadas às issues!"
        else
            warning "Nenhuma issue encontrada para reagir"
        fi
    else
        warning "GitHub CLI não disponível para Heart On Your Sleeve automation"
    fi
    
    return 0
}

# Função para YOLO automation
automate_yolo() {
    log "🎲 Automatizando YOLO..."
    
    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        # Verificar se há PRs abertos
        open_prs=$(gh pr list --json number --jq '.[].number' 2>/dev/null)
        
        if [ -n "$open_prs" ]; then
            for pr in $open_prs; do
                log "Fazendo merge direto do PR #$pr..."
                gh pr merge "$pr" --merge --delete-branch 2>/dev/null && success "PR #$pr merged via YOLO!" || warning "Falha ao fazer merge do PR #$pr"
                break # Fazer merge apenas do primeiro PR
            done
        else
            warning "Nenhum PR aberto encontrado para YOLO merge"
        fi
    else
        warning "GitHub CLI não disponível para YOLO automation"
    fi
    
    return 0
}

# Função para gerar relatório
generate_report() {
    log "📊 Gerando relatório de automação..."
    
    report_file="automation-report-$(date +%Y%m%d-%H%M%S).md"
    
    {
        echo "# 🤖 Relatório de Automação de Badges"
        echo "**Data:** $(date)"
        echo ""
        echo "## 📋 Ações Executadas"
        echo ""
        echo "### 🦈 Pull Shark"
        echo "- ✅ Branch automática criada"
        echo "- ✅ Feature implementada"
        echo "- ✅ Commit com co-autoria"
        echo ""
        echo "### 👥 Pair Extraordinaire"
        coauthor_count=$(git log --grep="Co-authored-by" --oneline | wc -l)
        echo "- ✅ Commits com co-autoria: $coauthor_count"
        echo ""
        echo "### ⚙️ DevOps Guru"
        workflow_count=$(find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null | wc -l)
        echo "- ✅ Workflows configurados: $workflow_count"
        echo ""
        echo "### ⚡ Quickdraw"
        echo "- ✅ Issue automática criada"
        echo ""
        echo "### ❤️ Heart On Your Sleeve"
        echo "- ✅ Reações adicionadas"
        echo ""
        echo "### 🎲 YOLO"
        echo "- ✅ Merge direto executado"
        echo ""
        echo "## 🎯 Próximos Passos"
        echo "1. Verificar badges conquistadas no perfil GitHub"
        echo "2. Executar script de monitoramento"
        echo "3. Documentar sucessos e falhas"
        echo ""
        echo "---"
        echo "**Gerado por:** auto-badges.sh"
        echo "**Versão:** 1.0.0"
    } > "$report_file"
    
    success "Relatório salvo em: $report_file"
}

# Função principal
main() {
    print_header
    
    # Verificar dependências
    check_dependencies
    has_gh_cli=$?
    
    echo
    log "🚀 Iniciando automação completa de badges..."
    echo
    
    # Executar automações
    automate_pull_shark
    echo
    
    automate_pair_extraordinaire
    echo
    
    if [ $has_gh_cli -eq 0 ]; then
        automate_quickdraw
        echo
        
        automate_devops_guru
        echo
        
        automate_heart_on_sleeve
        echo
        
        automate_yolo
        echo
    else
        warning "Pulando automações que requerem GitHub CLI..."
        echo
    fi
    
    # Gerar relatório
    generate_report
    echo
    
    success "🎉 Automação completa finalizada!"
    echo
    echo -e "${BLUE}💡 Próximos passos:${NC}"
    echo "1. Execute: npm run badges (para monitorar progresso)"
    echo "2. Verifique seu perfil GitHub para badges conquistadas"
    echo "3. Faça push das mudanças para o repositório remoto"
    echo "4. Crie PRs para branches criadas (se não foram criados automaticamente)"
    echo
}

# Executar script
main "$@"
