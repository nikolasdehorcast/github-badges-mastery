# 🏆 GitHub Badges Mastery - Monitor de Progresso (PowerShell)
# Script para monitorar o progresso das insígnias do GitHub

param(
    [switch]$SaveReport = $false
)

# Função para imprimir cabeçalho
function Write-Header {
    Write-Host "==================================" -ForegroundColor Magenta
    Write-Host "🏆 GITHUB BADGES PROGRESS MONITOR" -ForegroundColor Magenta
    Write-Host "Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Magenta
    Write-Host "==================================" -ForegroundColor Magenta
    Write-Host ""
}

# Função para log com timestamp
function Write-Log {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

# Função para sucesso
function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

# Função para erro
function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

# Função para warning
function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️ $Message" -ForegroundColor Yellow
}

# Função para verificar Pull Shark
function Test-PullShark {
    Write-Host "🦈 PULL SHARK STATUS" -ForegroundColor Blue
    Write-Host "Critério: 2+ Pull Requests merged"
    
    # Simular contagem de PRs (contando branches criadas)
    $branches = git branch -a 2>$null | Where-Object { $_ -match "feature/" }
    $prCount = if ($branches) { $branches.Count } else { 0 }
    
    Write-Host "PRs simulados (branches feature): " -NoNewline
    Write-Host "$prCount" -ForegroundColor Green
    
    if ($prCount -ge 2) {
        Write-Success "Status: ✅ CONQUISTADA"
    } else {
        Write-Warning "Status: 🔄 Em progresso (faltam $($2 - $prCount) PRs)"
    }
    Write-Host ""
}

# Função para verificar Pair Extraordinaire
function Test-PairExtraordinaire {
    Write-Host "👥 PAIR EXTRAORDINAIRE STATUS" -ForegroundColor Blue
    Write-Host "Critério: Co-autoria em commits"
    
    $coauthorCommits = git log --grep="Co-authored-by" --oneline 2>$null
    $coauthorCount = if ($coauthorCommits) { $coauthorCommits.Count } else { 0 }
    
    Write-Host "Commits com co-autoria: " -NoNewline
    Write-Host "$coauthorCount" -ForegroundColor Green
    
    if ($coauthorCount -ge 1) {
        Write-Success "Status: ✅ CONQUISTADA"
    } else {
        Write-Warning "Status: 🔄 Em progresso"
    }
    Write-Host ""
}

# Função para verificar DevOps Guru
function Test-DevOpsGuru {
    Write-Host "⚙️ DEVOPS GURU STATUS" -ForegroundColor Blue
    Write-Host "Critério: GitHub Actions configuradas"
    
    $workflowFiles = Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -ErrorAction SilentlyContinue
    $workflowCount = if ($workflowFiles) { $workflowFiles.Count } else { 0 }
    
    Write-Host "Workflows configurados: " -NoNewline
    Write-Host "$workflowCount" -ForegroundColor Green
    
    if ($workflowCount -ge 1) {
        Write-Success "Status: ✅ CONQUISTADA"
        
        if ($workflowFiles) {
            Write-Host "Workflows encontrados:"
            foreach ($workflow in $workflowFiles) {
                Write-Host "  - $($workflow.Name)" -ForegroundColor Gray
            }
        }
    } else {
        Write-Warning "Status: 🔄 Em progresso"
    }
    Write-Host ""
}

# Função para verificar Galaxy Brain
function Test-GalaxyBrain {
    Write-Host "🧠 GALAXY BRAIN STATUS" -ForegroundColor Blue
    Write-Host "Critério: Discussões aceitas"
    
    # Verificar se há arquivos de discussão configurados
    $discussionTemplates = Get-ChildItem -Path ".github" -Filter "*discussion*" -Recurse -ErrorAction SilentlyContinue
    
    if ($discussionTemplates) {
        Write-Host "Templates de discussão configurados: " -NoNewline
        Write-Host "$($discussionTemplates.Count)" -ForegroundColor Green
        Write-Warning "Status: 🔄 Aguardando criação de discussões"
    } else {
        Write-Warning "Status: ⏳ Pendente (configurar discussões)"
    }
    Write-Host ""
}

# Função para verificar Quickdraw
function Test-Quickdraw {
    Write-Host "⚡ QUICKDRAW STATUS" -ForegroundColor Blue
    Write-Host "Critério: Issue/PR criado em menos de 5 minutos"
    
    # Verificar se há workflow de auto-issue
    $autoIssueWorkflow = Get-ChildItem -Path ".github/workflows" -Filter "*auto-issue*" -ErrorAction SilentlyContinue
    
    if ($autoIssueWorkflow) {
        Write-Success "Status: ✅ CONQUISTADA (via automação)"
        Write-Host "Workflow de auto-issue configurado: $($autoIssueWorkflow.Name)" -ForegroundColor Gray
    } else {
        Write-Warning "Status: 🔄 Em progresso"
    }
    Write-Host ""
}

# Função para verificar Heart On Your Sleeve
function Test-HeartOnSleeve {
    Write-Host "❤️ HEART ON YOUR SLEEVE STATUS" -ForegroundColor Blue
    Write-Host "Critério: Reações em issues/PRs"
    Write-Warning "Status: 🔄 Aguardando implementação"
    Write-Host "Próximo passo: Adicionar reações em issues"
    Write-Host ""
}

# Função para verificar YOLO
function Test-YOLO {
    Write-Host "🎲 YOLO STATUS" -ForegroundColor Blue
    Write-Host "Critério: Merge sem review"
    Write-Warning "Status: 🔄 Aguardando implementação"
    Write-Host "Próximo passo: Configurar merge direto"
    Write-Host ""
}

# Função para gerar resumo
function Write-Summary {
    Write-Host "📊 RESUMO GERAL" -ForegroundColor Magenta
    Write-Host "=================================="
    
    $totalBadges = 7
    $conqueredBadges = 0
    
    # Contar badges conquistadas
    $coauthorCount = (git log --grep="Co-authored-by" --oneline 2>$null | Measure-Object).Count
    if ($coauthorCount -ge 1) { $conqueredBadges++ }
    
    $workflowCount = (Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -ErrorAction SilentlyContinue | Measure-Object).Count
    if ($workflowCount -ge 1) { $conqueredBadges++ }
    
    $autoIssueWorkflow = Get-ChildItem -Path ".github/workflows" -Filter "*auto-issue*" -ErrorAction SilentlyContinue
    if ($autoIssueWorkflow) { $conqueredBadges++ }
    
    Write-Host "Insígnias conquistadas: " -NoNewline
    Write-Host "$conqueredBadges" -ForegroundColor Green -NoNewline
    Write-Host "/$totalBadges"
    
    $percentage = [math]::Round(($conqueredBadges / $totalBadges) * 100)
    Write-Host "Progresso: " -NoNewline
    Write-Host "$percentage%" -ForegroundColor Green
    
    if ($conqueredBadges -eq $totalBadges) {
        Write-Success "🎉 PARABÉNS! Todas as insígnias foram conquistadas!"
    } else {
        Write-Warning "🎯 Continue trabalhando para conquistar todas as insígnias!"
    }
    Write-Host ""
}

# Função para salvar relatório
function Save-Report {
    $reportFile = "badge-progress-$(Get-Date -Format 'yyyyMMdd-HHmmss').md"
    
    $reportContent = @"
# 🏆 Relatório de Progresso das Insígnias

**Data:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Status das Insígnias

| Insígnia | Status | Observações |
|----------|--------|-------------|
| 🦈 Pull Shark | Em progresso | Verificar PRs merged |
| 👥 Pair Extraordinaire | Conquistada | Commits com co-autoria |
| ⚙️ DevOps Guru | Conquistada | Workflows configurados |
| 🧠 Galaxy Brain | Pendente | Habilitar discussões |
| ⚡ Quickdraw | Conquistada | Automação ativa |
| ❤️ Heart On Your Sleeve | Pendente | Implementar reações |
| 🎲 YOLO | Pendente | Configurar merges diretos |

## Métricas Atuais

- **Commits com co-autoria:** $(if (git log --grep="Co-authored-by" --oneline 2>$null) { (git log --grep="Co-authored-by" --oneline 2>$null).Count } else { 0 })
- **Workflows configurados:** $(if (Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -ErrorAction SilentlyContinue) { (Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -ErrorAction SilentlyContinue).Count } else { 0 })
- **Branches criadas:** $(if (git branch -a 2>$null) { (git branch -a 2>$null | Where-Object { $_ -match "feature/" }).Count } else { 0 })

## Próximos Passos

1. Continuar criando PRs para Pull Shark
2. Habilitar discussões para Galaxy Brain
3. Implementar sistema de reações
4. Configurar merges diretos para YOLO

---

**Gerado por:** badge-monitor.ps1  
**Versão:** 1.0.0
"@

    $reportContent | Out-File -FilePath $reportFile -Encoding UTF8
    Write-Success "📄 Relatório salvo em: $reportFile"
}

# Função principal
function Main {
    Write-Header
    
    Write-Log "🚀 Iniciando verificação de badges..."
    Write-Host ""
    
    Test-PullShark
    Test-PairExtraordinaire
    Test-DevOpsGuru
    Test-GalaxyBrain
    Test-Quickdraw
    Test-HeartOnSleeve
    Test-YOLO
    Write-Summary
    
    if ($SaveReport) {
        Save-Report
        Write-Host ""
    }
    
    Write-Success "🎉 Verificação completa finalizada!"
    Write-Host ""
    Write-Host "💡 Próximos passos:" -ForegroundColor Blue
    Write-Host "1. Execute: npm test (para verificar funcionalidades)"
    Write-Host "2. Verifique seu perfil GitHub para badges conquistadas"
    Write-Host "3. Continue implementando estratégias pendentes"
    Write-Host "4. Execute este script regularmente para monitorar progresso"
    Write-Host ""
}

# Executar script
Main
