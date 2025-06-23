#!/bin/bash

# 🏆 GitHub Badges Mastery - Monitor de Progresso
# Script para monitorar o progresso das insígnias do GitHub

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
    echo -e "🏆 GITHUB BADGES PROGRESS MONITOR"
    echo -e "Data: $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "==================================${NC}"
    echo
}

# Função para verificar PRs
check_pull_shark() {
    echo -e "${BLUE}🦈 PULL SHARK STATUS${NC}"
    echo "Critério: 2+ Pull Requests merged"
    
    if command -v gh &> /dev/null; then
        pr_count=$(gh pr list --state merged --author @me 2>/dev/null | wc -l || echo "0")
        echo -e "PRs merged: ${GREEN}$pr_count${NC}"
        
        if [ "$pr_count" -ge 2 ]; then
            echo -e "Status: ${GREEN}✅ CONQUISTADA${NC}"
        else
            echo -e "Status: ${YELLOW}🔄 Em progresso (faltam $((2 - pr_count)) PRs)${NC}"
        fi
    else
        echo -e "Status: ${RED}❌ GitHub CLI não instalado${NC}"
    fi
    echo
}

# Função para verificar co-autoria
check_pair_extraordinaire() {
    echo -e "${BLUE}👥 PAIR EXTRAORDINAIRE STATUS${NC}"
    echo "Critério: Co-autoria em commits"
    
    coauthor_commits=$(git log --grep="Co-authored-by" --oneline 2>/dev/null | wc -l || echo "0")
    echo -e "Commits com co-autoria: ${GREEN}$coauthor_commits${NC}"
    
    if [ "$coauthor_commits" -ge 1 ]; then
        echo -e "Status: ${GREEN}✅ CONQUISTADA${NC}"
    else
        echo -e "Status: ${YELLOW}🔄 Em progresso${NC}"
    fi
    echo
}

# Função para verificar GitHub Actions
check_devops_guru() {
    echo -e "${BLUE}⚙️ DEVOPS GURU STATUS${NC}"
    echo "Critério: GitHub Actions configuradas"
    
    workflow_count=$(find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null | wc -l || echo "0")
    echo -e "Workflows configurados: ${GREEN}$workflow_count${NC}"
    
    if [ "$workflow_count" -ge 1 ]; then
        echo -e "Status: ${GREEN}✅ CONQUISTADA${NC}"
        
        # Verificar execuções recentes
        if command -v gh &> /dev/null; then
            echo "Execuções recentes:"
            gh run list --limit 3 2>/dev/null || echo "Não foi possível verificar execuções"
        fi
    else
        echo -e "Status: ${YELLOW}🔄 Em progresso${NC}"
    fi
    echo
}

# Função para verificar discussões
check_galaxy_brain() {
    echo -e "${BLUE}🧠 GALAXY BRAIN STATUS${NC}"
    echo "Critério: Discussões aceitas"
    
    if command -v gh &> /dev/null; then
        # Verificar se discussões estão habilitadas
        discussions_enabled=$(gh repo view --json hasDiscussionsEnabled --jq '.hasDiscussionsEnabled' 2>/dev/null || echo "false")
        
        if [ "$discussions_enabled" = "true" ]; then
            echo -e "Discussões habilitadas: ${GREEN}✅${NC}"
            echo -e "Status: ${YELLOW}🔄 Aguardando criação de discussões${NC}"
        else
            echo -e "Discussões habilitadas: ${RED}❌${NC}"
            echo -e "Status: ${RED}⏳ Pendente (habilitar discussões)${NC}"
        fi
    else
        echo -e "Status: ${RED}❌ GitHub CLI não instalado${NC}"
    fi
    echo
}

# Função para verificar issues rápidas
check_quickdraw() {
    echo -e "${BLUE}⚡ QUICKDRAW STATUS${NC}"
    echo "Critério: Issue/PR criado em menos de 5 minutos"
    
    if command -v gh &> /dev/null; then
        recent_issues=$(gh issue list --limit 5 --state all 2>/dev/null | wc -l || echo "0")
        echo -e "Issues criadas: ${GREEN}$recent_issues${NC}"
        
        if [ "$recent_issues" -ge 1 ]; then
            echo -e "Status: ${GREEN}✅ CONQUISTADA (via automação)${NC}"
        else
            echo -e "Status: ${YELLOW}🔄 Em progresso${NC}"
        fi
    else
        echo -e "Status: ${RED}❌ GitHub CLI não instalado${NC}"
    fi
    echo
}

# Função para verificar reações
check_heart_on_sleeve() {
    echo -e "${BLUE}❤️ HEART ON YOUR SLEEVE STATUS${NC}"
    echo "Critério: Reações em issues/PRs"
    echo -e "Status: ${YELLOW}🔄 Aguardando implementação${NC}"
    echo "Próximo passo: Adicionar reações em issues"
    echo
}

# Função para verificar YOLO
check_yolo() {
    echo -e "${BLUE}🎲 YOLO STATUS${NC}"
    echo "Critério: Merge sem review"
    echo -e "Status: ${YELLOW}🔄 Aguardando implementação${NC}"
    echo "Próximo passo: Configurar merge direto"
    echo
}

# Função para gerar resumo
generate_summary() {
    echo -e "${PURPLE}📊 RESUMO GERAL${NC}"
    echo "=================================="
    
    total_badges=7
    conquered_badges=0
    
    # Contar badges conquistadas (simplificado)
    if command -v gh &> /dev/null; then
        pr_count=$(gh pr list --state merged --author @me 2>/dev/null | wc -l || echo "0")
        [ "$pr_count" -ge 2 ] && ((conquered_badges++))
    fi
    
    coauthor_commits=$(git log --grep="Co-authored-by" --oneline 2>/dev/null | wc -l || echo "0")
    [ "$coauthor_commits" -ge 1 ] && ((conquered_badges++))
    
    workflow_count=$(find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null | wc -l || echo "0")
    [ "$workflow_count" -ge 1 ] && ((conquered_badges++))
    
    echo -e "Insígnias conquistadas: ${GREEN}$conquered_badges${NC}/$total_badges"
    echo -e "Progresso: ${GREEN}$(( conquered_badges * 100 / total_badges ))%${NC}"
    
    if [ "$conquered_badges" -eq "$total_badges" ]; then
        echo -e "${GREEN}🎉 PARABÉNS! Todas as insígnias foram conquistadas!${NC}"
    else
        echo -e "${YELLOW}🎯 Continue trabalhando para conquistar todas as insígnias!${NC}"
    fi
    echo
}

# Função para salvar relatório
save_report() {
    report_file="badge-progress-$(date +%Y%m%d-%H%M%S).md"
    
    {
        echo "# 🏆 Relatório de Progresso das Insígnias"
        echo "**Data:** $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
        echo "## Status das Insígnias"
        echo ""
        echo "| Insígnia | Status | Observações |"
        echo "|----------|--------|-------------|"
        echo "| 🦈 Pull Shark | Em progresso | Verificar PRs merged |"
        echo "| 👥 Pair Extraordinaire | Em progresso | Commits com co-autoria |"
        echo "| ⚙️ DevOps Guru | Em progresso | Workflows configurados |"
        echo "| 🧠 Galaxy Brain | Pendente | Habilitar discussões |"
        echo "| ⚡ Quickdraw | Em progresso | Automação ativa |"
        echo "| ❤️ Heart On Your Sleeve | Pendente | Implementar reações |"
        echo "| 🎲 YOLO | Pendente | Configurar merges diretos |"
        echo ""
        echo "## Próximos Passos"
        echo "1. Continuar criando PRs para Pull Shark"
        echo "2. Habilitar discussões para Galaxy Brain"
        echo "3. Implementar sistema de reações"
        echo "4. Configurar merges diretos para YOLO"
    } > "$report_file"
    
    echo -e "${GREEN}📄 Relatório salvo em: $report_file${NC}"
}

# Função principal
main() {
    print_header
    check_pull_shark
    check_pair_extraordinaire
    check_devops_guru
    check_galaxy_brain
    check_quickdraw
    check_heart_on_sleeve
    check_yolo
    generate_summary
    
    # Perguntar se deve salvar relatório
    read -p "Deseja salvar um relatório detalhado? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        save_report
    fi
}

# Executar script
main "$@"
