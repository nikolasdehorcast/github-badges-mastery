# ⚡ Comandos Rápidos para GitHub Badges

Coleção de comandos e scripts para acelerar a conquista de insígnias do GitHub.

## 🚀 Setup Inicial

```bash
# Clonar e configurar repositório
git clone https://github.com/SEU_USERNAME/github-badges-mastery.git
cd github-badges-mastery

# Configurar Git para co-autoria
git config commit.template .gitmessage

# Instalar GitHub CLI (se necessário)
# Windows: winget install GitHub.cli
# Mac: brew install gh
# Linux: apt install gh

# Autenticar GitHub CLI
gh auth login
```

## 🦈 Pull Shark - Comandos Rápidos

```bash
# Criar branch e feature rapidamente
git checkout -b feature/nova-funcionalidade
echo "# Nova Funcionalidade" > nova-feature.md
git add nova-feature.md
git commit -m "feat: adicionar nova funcionalidade

Co-authored-by: GitHub Copilot <copilot@github.com>"
git push origin feature/nova-funcionalidade

# Criar PR via CLI
gh pr create --title "feat: nova funcionalidade" --body "Implementação de nova funcionalidade para badge Pull Shark"

# Fazer merge
gh pr merge --merge --delete-branch
```

## 👥 Pair Extraordinaire - Templates de Commit

```bash
# Commit básico com co-autoria
git commit -m "feat: implementar funcionalidade

Co-authored-by: GitHub Copilot <copilot@github.com>"

# Commit com múltiplos co-autores
git commit -m "feat: implementar funcionalidade complexa

Implementação colaborativa com múltiplos contribuidores.

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Assistant <assistant@badges-mastery.com>
Co-authored-by: Code Reviewer <reviewer@badges-mastery.com>"

# Configurar alias para commit rápido
git config alias.pair-commit '!f() { git commit -m "$1

Co-authored-by: GitHub Copilot <copilot@github.com>"; }; f'

# Usar alias
git pair-commit "feat: nova funcionalidade"
```

## ⚙️ DevOps Guru - Trigger de Workflows

```bash
# Executar workflow manualmente
gh workflow run ci.yml

# Executar workflow específico
gh workflow run auto-issue.yml

# Listar workflows disponíveis
gh workflow list

# Ver status dos workflows
gh run list

# Ver detalhes de uma execução
gh run view [RUN_ID]
```

## 🧠 Galaxy Brain - Discussões Rápidas

```bash
# Criar discussão via API (requer configuração)
gh api graphql -f query='
mutation {
  createDiscussion(input: {
    repositoryId: "REPO_ID"
    categoryId: "CATEGORY_ID"
    title: "💡 Nova Ideia para Badges"
    body: "Discussão sobre estratégias para conquistar badges mais rapidamente."
  }) {
    discussion {
      id
      url
    }
  }
}'

# Listar discussões
gh api repos/:owner/:repo/discussions

# Criar discussão via interface (mais fácil)
# Ir para: https://github.com/SEU_USERNAME/github-badges-mastery/discussions/new
```

## ⚡ Quickdraw - Issues em Segundos

```bash
# Issue rápida básica
gh issue create --title "📋 Task rápida" --body "Issue criada em menos de 5 minutos" --label "quickdraw"

# Issue com template
gh issue create --title "🐛 Bug encontrado" --body "Bug reportado rapidamente" --label "bug,quickdraw"

# Issue de planejamento
gh issue create --title "📅 Planejamento semanal" --body "## Objetivos da semana
- [ ] Conquistar Pull Shark
- [ ] Implementar DevOps Guru
- [ ] Criar discussões" --label "planning,quickdraw"

# Configurar alias para issues rápidas
gh alias set quick-issue 'issue create --title "⚡ Quick: " --body "Issue criada rapidamente para badge Quickdraw" --label "quickdraw"'

# Usar alias
gh quick-issue
```

## ❤️ Heart On Your Sleeve - Reações Rápidas

```bash
# Listar issues para reagir
gh issue list

# Reagir via API (exemplo para issue #1)
gh api repos/:owner/:repo/issues/1/reactions -f content="+1"
gh api repos/:owner/:repo/issues/1/reactions -f content="heart"
gh api repos/:owner/:repo/issues/1/reactions -f content="hooray"
gh api repos/:owner/:repo/issues/1/reactions -f content="rocket"

# Script para reagir a múltiplas issues
for i in {1..5}; do
  gh api repos/:owner/:repo/issues/$i/reactions -f content="+1" 2>/dev/null || true
done
```

## 🎲 YOLO - Merge Direto

```bash
# Criar PR e fazer merge imediato
git checkout -b fix/quick-fix
echo "fix aplicado" > quick-fix.txt
git add quick-fix.txt
git commit -m "fix: aplicar correção rápida

Co-authored-by: GitHub Copilot <copilot@github.com>"
git push origin fix/quick-fix

# Criar e fazer merge em um comando
gh pr create --title "fix: correção rápida" --body "Fix aplicado diretamente" && gh pr merge --merge --delete-branch
```

## 📊 Monitoramento - Comandos de Status

```bash
# Executar monitor de badges
npm run badges

# Ou executar script diretamente
bash scripts/badge-monitor.sh

# Verificar status do repositório
gh repo view

# Ver estatísticas de PRs
gh pr list --state merged --author @me

# Ver commits com co-autoria
git log --grep="Co-authored-by" --oneline

# Contar workflows
ls .github/workflows/ | wc -l

# Ver execuções recentes
gh run list --limit 10
```

## 🔄 Automação Completa - Script All-in-One

```bash
#!/bin/bash
# Script para conquistar múltiplas badges rapidamente

echo "🚀 Iniciando conquista de badges..."

# 1. Pull Shark - Criar PR
git checkout -b feature/auto-badge-$(date +%s)
echo "# Auto Badge Feature $(date)" > auto-feature.md
git add auto-feature.md
git commit -m "feat: auto feature para badges

Co-authored-by: GitHub Copilot <copilot@github.com>"
git push origin feature/auto-badge-$(date +%s)
gh pr create --title "feat: auto feature" --body "Feature automática para badges"

# 2. Quickdraw - Issue rápida
gh issue create --title "⚡ Auto issue $(date +%H:%M)" --body "Issue criada automaticamente" --label "quickdraw"

# 3. DevOps Guru - Trigger workflow
gh workflow run ci.yml

# 4. Heart On Your Sleeve - Reagir
gh api repos/:owner/:repo/issues/1/reactions -f content="rocket" 2>/dev/null || true

echo "✅ Badges em progresso!"
```

## 🎯 Aliases Úteis do GitHub CLI

```bash
# Configurar aliases úteis
gh alias set pr-quick 'pr create --title "feat: " --body "Quick feature implementation"'
gh alias set issue-quick 'issue create --title "📋 " --body "Quick issue" --label "quickdraw"'
gh alias set merge-yolo 'pr merge --merge --delete-branch'
gh alias set badges-status 'run list --limit 5'

# Usar aliases
gh pr-quick
gh issue-quick
gh merge-yolo
gh badges-status
```

## 📱 Comandos Mobile-Friendly

Para usar no celular via GitHub Mobile ou Termux:

```bash
# Comandos curtos
gh pr create -t "feat" -b "quick"
gh issue create -t "task" -b "quick"
gh workflow run ci.yml
gh pr merge -m
```

## 🔧 Troubleshooting

```bash
# Verificar autenticação
gh auth status

# Reautenticar se necessário
gh auth login

# Verificar permissões do repositório
gh repo view

# Verificar se workflows estão habilitados
gh workflow list

# Debug de workflow
gh run view --log [RUN_ID]
```

## 📈 Métricas Rápidas

```bash
# Contar PRs merged
gh pr list --state merged --author @me | wc -l

# Contar commits com co-autoria
git log --grep="Co-authored-by" --oneline | wc -l

# Contar workflows
find .github/workflows -name "*.yml" | wc -l

# Contar issues criadas
gh issue list --author @me | wc -l

# Ver últimas execuções de workflow
gh run list --limit 3
```

---

## 💡 Dicas de Produtividade

1. **Use aliases:** Configure aliases para comandos frequentes
2. **Scripts batch:** Crie scripts para executar múltiplas ações
3. **Templates:** Use templates para acelerar criação de conteúdo
4. **Automação:** Configure workflows para tarefas repetitivas
5. **Monitoramento:** Execute verificações regulares de progresso

---

**Última atualização:** $(date)  
**Versão:** 1.0.0
