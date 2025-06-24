# 🏆 GitHub Badges Master Monitor - Versão Completa
# Script PowerShell para monitoramento avançado de badges

param(
    [switch]$GenerateReport,
    [switch]$AutoCommit,
    [switch]$ShowQuickCommands,
    [string]$BadgeFilter = "all"
)

# Configuração de cores
$Script:Colors = @{
    Title     = "Magenta"
    Success   = "Green"
    Warning   = "Yellow"
    Error     = "Red"
    Info      = "Cyan"
    Highlight = "White"
    Subtle    = "Gray"
}

function Write-BadgeTitle {
    param([string]$Title)
    Write-Host ""
    Write-Host "🏆 $Title" -ForegroundColor $Script:Colors.Title
    Write-Host ("=" * ($Title.Length + 3)) -ForegroundColor $Script:Colors.Title
}

function Write-StatusLine {
    param([string]$Badge, [string]$Status, [string]$Details, [string]$Emoji)
    
    $color = switch -Regex ($Status) {
        "ACHIEVED|COMPLETED" { $Script:Colors.Success }
        "READY|CONFIGURED" { $Script:Colors.Warning }
        "PENDING|WAITING" { $Script:Colors.Info }
        default { $Script:Colors.Subtle }
    }
    
    Write-Host "$Emoji $Badge" -ForegroundColor $color -NoNewline
    Write-Host " - " -NoNewline
    Write-Host $Status -ForegroundColor $color -NoNewline
    Write-Host " ($Details)" -ForegroundColor $Script:Colors.Subtle
}

function Test-AllBadges {
    $badges = @{}
    
    # 🦈 Pull Shark
    try {
        $mergedBranches = @(git branch -r --merged 2>$null | Where-Object { 
            $_ -notmatch "HEAD" -and $_ -notmatch "/main" -and $_ -notmatch "/master" 
        })
        $prCount = $mergedBranches.Count
        
        $badges["PullShark"] = @{
            Emoji = "🦈"
            Status = if ($prCount -ge 2) { "✅ ACHIEVED" } else { "🔄 IN PROGRESS" }
            Count = $prCount
            Required = 2
            Details = "$prCount/2 merged PRs"
            NextAction = if ($prCount -lt 2) { "Create $((2 - $prCount)) more feature branch(es) and merge as PR" } else { "Complete!" }
        }
    } catch {
        $badges["PullShark"] = @{
            Emoji = "🦈"
            Status = "❓ ERROR"
            Count = 0
            Required = 2
            Details = "Cannot check PR status"
            NextAction = "Fix git repository access"
        }
    }
    
    # 👥 Pair Extraordinaire
    try {
        $coAuthoredCommits = @(git log --grep="Co-authored-by" --oneline 2>$null)
        $coAuthorCount = $coAuthoredCommits.Count
        
        $badges["PairExtraordinaire"] = @{
            Emoji = "👥"
            Status = if ($coAuthorCount -ge 1) { "✅ ACHIEVED" } else { "⏳ PENDING" }
            Count = $coAuthorCount
            Required = 1
            Details = "$coAuthorCount co-authored commits"
            NextAction = if ($coAuthorCount -lt 1) { "Add co-authors to commits" } else { "Complete!" }
        }
    } catch {
        $badges["PairExtraordinaire"] = @{
            Emoji = "👥"
            Status = "❓ ERROR"
            Count = 0
            Required = 1
            Details = "Cannot check commit history"
            NextAction = "Fix git repository access"
        }
    }
    
    # ⚙️ DevOps Guru
    $workflowFiles = @(Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -ErrorAction SilentlyContinue)
    $workflowCount = $workflowFiles.Count
    
    $badges["DevOpsGuru"] = @{
        Emoji = "⚙️"
        Status = if ($workflowCount -ge 1) { "✅ ACHIEVED" } else { "⏳ PENDING" }
        Count = $workflowCount
        Required = 1
        Details = "$workflowCount GitHub Actions workflows"
        NextAction = if ($workflowCount -lt 1) { "Create GitHub Actions workflow" } else { "Run workflows to confirm!" }
    }
    
    # 🧠 Galaxy Brain
    $discussionTemplates = @(Get-ChildItem -Path ".github/DISCUSSION_TEMPLATE" -Filter "*.yml" -ErrorAction SilentlyContinue)
    $discussionCount = $discussionTemplates.Count
    
    $badges["GalaxyBrain"] = @{
        Emoji = "🧠"
        Status = if ($discussionCount -ge 1) { "🔄 READY" } else { "⏳ PENDING" }
        Count = $discussionCount
        Required = 1
        Details = "$discussionCount discussion templates"
        NextAction = if ($discussionCount -ge 1) { "Enable discussions in repo settings & create discussions" } else { "Create discussion templates" }
    }
    
    # ⚡ Quickdraw
    $quickdrawWorkflow = Test-Path ".github/workflows/quickdraw-issues.yml"
    $issueTemplates = @(Get-ChildItem -Path ".github/ISSUE_TEMPLATE" -Filter "*.yml" -ErrorAction SilentlyContinue)
    
    $badges["Quickdraw"] = @{
        Emoji = "⚡"
        Status = if ($quickdrawWorkflow -and $issueTemplates.Count -gt 0) { "🔄 READY" } else { "⏳ PENDING" }
        Count = if ($quickdrawWorkflow) { 1 } else { 0 }
        Required = 1
        Details = "Quickdraw workflow: $(if ($quickdrawWorkflow) { 'Ready' } else { 'Missing' })"
        NextAction = if ($quickdrawWorkflow) { "Run quickdraw workflow to create issues fast" } else { "Create quickdraw workflow" }
    }
    
    # 🎲 YOLO
    $yoloWorkflow = Test-Path ".github/workflows/yolo-merge.yml"
    
    $badges["YOLO"] = @{
        Emoji = "🎲"
        Status = if ($yoloWorkflow) { "🎲 READY" } else { "⏳ PENDING" }
        Count = if ($yoloWorkflow) { 1 } else { 0 }
        Required = 1
        Details = "YOLO workflow: $(if ($yoloWorkflow) { 'Ready' } else { 'Missing' })"
        NextAction = if ($yoloWorkflow) { "Run YOLO workflow for direct merge" } else { "Create YOLO workflow" }
    }
    
    # ❤️ Heart On Your Sleeve
    $reactionCapable = (Test-Path ".github/workflows/quickdraw-issues.yml") -or (Test-Path ".github/workflows/badge-monitor.yml")
    
    $badges["HeartOnYourSleeve"] = @{
        Emoji = "❤️"
        Status = if ($reactionCapable) { "🔄 READY" } else { "⏳ PENDING" }
        Count = if ($reactionCapable) { 1 } else { 0 }
        Required = 1
        Details = "Auto-reaction: $(if ($reactionCapable) { 'Configured' } else { 'Missing' })"
        NextAction = if ($reactionCapable) { "Run workflows that add reactions to issues" } else { "Configure reaction workflows" }
    }
    
    return $badges
}

function Show-BadgeOverview {
    param($badges)
    
    Write-BadgeTitle "GITHUB BADGES STATUS OVERVIEW"
    Write-Host "📅 Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor $Script:Colors.Info
    Write-Host ""
    
    $achievedCount = 0
    $readyCount = 0
    $totalBadges = $badges.Count
    
    foreach ($badgeName in $badges.Keys | Sort-Object) {
        $badge = $badges[$badgeName]
        
        if ($badge.Status -match "ACHIEVED|COMPLETED") {
            $achievedCount++
        } elseif ($badge.Status -match "READY") {
            $readyCount++
        }
        
        Write-StatusLine -Badge $badgeName -Status $badge.Status -Details $badge.Details -Emoji $badge.Emoji
    }
    
    Write-Host ""
    $percentage = [math]::Round(($achievedCount / $totalBadges) * 100)
    Write-Host "🏆 PROGRESS SUMMARY" -ForegroundColor $Script:Colors.Highlight
    Write-Host "✅ Achieved: $achievedCount/$totalBadges badges ($percentage%)" -ForegroundColor $Script:Colors.Success
    Write-Host "🔄 Ready to achieve: $readyCount badges" -ForegroundColor $Script:Colors.Warning
    Write-Host "⏳ Pending setup: $(($totalBadges - $achievedCount - $readyCount)) badges" -ForegroundColor $Script:Colors.Info
    Write-Host ""
}

function Show-ActionPlan {
    param($badges)
    
    Write-BadgeTitle "RECOMMENDED ACTION PLAN"
    
    $priorityOrder = @("PairExtraordinaire", "DevOpsGuru", "Quickdraw", "YOLO", "HeartOnYourSleeve", "PullShark", "GalaxyBrain")
    $actionCount = 1
    
    foreach ($badgeName in $priorityOrder) {
        $badge = $badges[$badgeName]
        
        if ($badge.Status -notmatch "ACHIEVED|COMPLETED") {
            Write-Host "$actionCount. $($badge.Emoji) $badgeName" -ForegroundColor $Script:Colors.Warning -NoNewline
            Write-Host " - $($badge.NextAction)" -ForegroundColor $Script:Colors.Info
            $actionCount++
        }
    }
    
    if ($actionCount -eq 1) {
        Write-Host "🎉 All badges are ready or achieved! Check your GitHub profile." -ForegroundColor $Script:Colors.Success
    }
    Write-Host ""
}

function Show-QuickCommandsMenu {
    if (-not $ShowQuickCommands) { return }
    
    Write-BadgeTitle "QUICK COMMANDS MENU"
    
    Write-Host "👥 CREATE CO-AUTHORED COMMIT:" -ForegroundColor $Script:Colors.Info
    Write-Host '   git commit -m "feat: new feature" -m "Co-authored-by: GitHub Copilot <copilot@github.com>"' -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
    
    Write-Host "🦈 CREATE FEATURE BRANCH FOR PR:" -ForegroundColor $Script:Colors.Info
    Write-Host "   git checkout -b feature/badge-enhancement-$(Get-Date -Format 'yyyyMMdd')" -ForegroundColor $Script:Colors.Subtle
    Write-Host "   # Make changes, commit, push, create PR via GitHub web interface" -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
    
    Write-Host "⚡ TRIGGER QUICKDRAW (create issues fast):" -ForegroundColor $Script:Colors.Info
    Write-Host "   gh workflow run quickdraw-issues.yml" -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
    
    Write-Host "🎲 TRIGGER YOLO (direct merge):" -ForegroundColor $Script:Colors.Info
    Write-Host "   gh workflow run yolo-merge.yml" -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
    
    Write-Host "⚙️ RUN ALL WORKFLOWS:" -ForegroundColor $Script:Colors.Info
    Write-Host "   gh workflow run ci.yml" -ForegroundColor $Script:Colors.Subtle
    Write-Host "   gh workflow run badge-monitor.yml" -ForegroundColor $Script:Colors.Subtle
    Write-Host "   gh workflow run pair-programming.yml" -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
    
    Write-Host "📊 CHECK WORKFLOW STATUS:" -ForegroundColor $Script:Colors.Info
    Write-Host "   gh run list --limit 10" -ForegroundColor $Script:Colors.Subtle
    Write-Host ""
}

function Generate-DetailedReport {
    param($badges)
    
    if (-not $GenerateReport) { return }
    
    $reportDir = "reports"
    if (-not (Test-Path $reportDir)) {
        New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    }
    
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $reportFile = "$reportDir/badge-progress-$timestamp.md"
    
    $achievedCount = ($badges.Values | Where-Object { $_.Status -match "ACHIEVED|COMPLETED" }).Count
    $readyCount = ($badges.Values | Where-Object { $_.Status -match "READY" }).Count
    $percentage = [math]::Round(($achievedCount / $badges.Count) * 100)
    
    $report = @"
# 🏆 GitHub Badges Mastery - Progress Report

**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  
**Repository:** github-badges-mastery  
**Overall Progress:** $achievedCount/$($badges.Count) badges achieved ($percentage%)  
**Ready to achieve:** $readyCount badges  

## 📊 Detailed Badge Status

| Badge | Status | Progress | Next Action |
|-------|--------|----------|-------------|
"@
    
    foreach ($badgeName in ($badges.Keys | Sort-Object)) {
        $badge = $badges[$badgeName]
        $report += "| $($badge.Emoji) **$badgeName** | $($badge.Status) | $($badge.Details) | $($badge.NextAction) |`n"
    }
    
    $report += @"

## 🎯 Immediate Action Items

### High Priority (Ready to Execute)
"@
    
    $highPriorityActions = @()
    $mediumPriorityActions = @()
    
    foreach ($badgeName in $badges.Keys) {
        $badge = $badges[$badgeName]
        if ($badge.Status -match "READY") {
            $highPriorityActions += "- $($badge.Emoji) **$badgeName**: $($badge.NextAction)"
        } elseif ($badge.Status -match "PENDING|WAITING") {
            $mediumPriorityActions += "- $($badge.Emoji) **$badgeName**: $($badge.NextAction)"
        }
    }
    
    if ($highPriorityActions.Count -gt 0) {
        $report += "`n" + ($highPriorityActions -join "`n") + "`n"
    } else {
        $report += "`n🎉 No high priority actions needed!`n"
    }
    
    $report += @"

### Medium Priority (Setup Required)
"@
    
    if ($mediumPriorityActions.Count -gt 0) {
        $report += "`n" + ($mediumPriorityActions -join "`n") + "`n"
    } else {
        $report += "`n✅ All badges are configured and ready!`n"
    }
    
    $report += @"

## 🚀 Quick Commands

### Essential Commands for Badge Achievement

```bash
# 👥 Pair Extraordinaire - Co-authored commit
git commit -m "feat: enhance badge system" -m "Co-authored-by: GitHub Copilot <copilot@github.com>"

# 🦈 Pull Shark - Create feature branch for PR
git checkout -b feature/badge-enhancement-$(date +%Y%m%d)
# Make changes, commit, push, create PR

# ⚡ Quickdraw - Create issues quickly
gh workflow run quickdraw-issues.yml

# 🎲 YOLO - Direct merge workflow
gh workflow run yolo-merge.yml

# ⚙️ DevOps Guru - Run CI workflows
gh workflow run ci.yml
```

## 📈 Progress Tracking

- **Achieved Badges:** $achievedCount/$($badges.Count) ($percentage%)
- **Ready to Achieve:** $readyCount badges
- **Estimated Time to Complete:** $(if ($readyCount -gt 0) { "1-2 hours" } else { "Already optimized!" })

## 🎯 Success Metrics

- ✅ All GitHub Actions workflows configured
- ✅ Templates created for quick issue/discussion creation
- ✅ Automation ready for rapid badge achievement
- ✅ Monitoring system in place

---

*Report generated automatically by GitHub Badges Mastery Monitor*  
*Next report: $(Get-Date (Get-Date).AddDays(1) -Format 'yyyy-MM-dd')*
"@
    
    $report | Out-File -FilePath $reportFile -Encoding UTF8 -Force
    Write-Host "📝 Detailed report saved: $reportFile" -ForegroundColor $Script:Colors.Success
    
    return $reportFile
}

function Invoke-AutoCommit {
    param($reportFile)
    
    if (-not $AutoCommit -or -not $reportFile) { return }
    
    try {
        git add $reportFile
        git add "reports/"
        
        $commitMessage = @"
📊 Auto-generated badge progress report

Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Report: $reportFile

This commit demonstrates automated monitoring and reporting
for GitHub badge achievement tracking.

Co-authored-by: Badge Monitor Bot <monitor@badges.com>
"@
        
        git commit -m $commitMessage
        Write-Host "✅ Progress report committed automatically!" -ForegroundColor $Script:Colors.Success
        Write-Host "📤 Run 'git push' to update remote repository" -ForegroundColor $Script:Colors.Info
    } catch {
        Write-Host "⚠️ Could not auto-commit: $($_.Exception.Message)" -ForegroundColor $Script:Colors.Warning
    }
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

Write-Host ""
Write-Host "🏆 ================================= 🏆" -ForegroundColor $Script:Colors.Title
Write-Host "    GITHUB BADGES MASTERY MONITOR    " -ForegroundColor $Script:Colors.Title  
Write-Host "🏆 ================================= 🏆" -ForegroundColor $Script:Colors.Title
Write-Host ""

# Verify git repository
if (-not (Test-Path ".git")) {
    Write-Host "❌ ERROR: Not in a git repository!" -ForegroundColor $Script:Colors.Error
    Write-Host "Please run this script from the root of your git repository." -ForegroundColor $Script:Colors.Info
    exit 1
}

# Test all badges
Write-Host "🔍 Analyzing repository for badge progress..." -ForegroundColor $Script:Colors.Info
$badges = Test-AllBadges

# Show results
Show-BadgeOverview $badges
Show-ActionPlan $badges
Show-QuickCommandsMenu

# Generate report if requested
$reportFile = Generate-DetailedReport $badges

# Auto-commit if requested
Invoke-AutoCommit $reportFile

# Final message
$achievedCount = ($badges.Values | Where-Object { $_.Status -match "ACHIEVED" }).Count
$readyCount = ($badges.Values | Where-Object { $_.Status -match "READY" }).Count

Write-Host "🎉 MONITORING COMPLETE!" -ForegroundColor $Script:Colors.Success
Write-Host ""

if ($achievedCount -eq $badges.Count) {
    Write-Host "🏆 CONGRATULATIONS! All badges achieved! 🏆" -ForegroundColor $Script:Colors.Success
} elseif ($readyCount -gt 0) {
    Write-Host "🚀 You have $readyCount badge(s) ready to achieve!" -ForegroundColor $Script:Colors.Warning
    Write-Host "💡 TIP: Run the suggested workflows to unlock them quickly!" -ForegroundColor $Script:Colors.Info
} else {
    Write-Host "📋 Follow the action plan above to progress toward badge achievement!" -ForegroundColor $Script:Colors.Info
}

Write-Host ""
Write-Host "📖 For detailed commands, run: .\scripts\badge-monitor.ps1 -ShowQuickCommands" -ForegroundColor $Script:Colors.Subtle
Write-Host "📊 For detailed report, run: .\scripts\badge-monitor.ps1 -GenerateReport" -ForegroundColor $Script:Colors.Subtle
Write-Host ""
