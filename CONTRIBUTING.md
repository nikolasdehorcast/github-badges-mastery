# 🤝 Contribuindo para GitHub Badges Mastery

Obrigado por seu interesse em contribuir para o GitHub Badges Mastery! Este projeto é dedicado a demonstrar estratégias sistemáticas para conquistar insígnias do GitHub.

## 🎯 Objetivo do Projeto

Este repositório serve como um laboratório para:
- Conquistar todas as insígnias possíveis do GitHub
- Documentar estratégias replicáveis
- Automatizar processos de conquista de badges
- Criar valor através de projetos estruturados

## 🚀 Como Contribuir

### 1. Preparação do Ambiente

```bash
# Fork e clone o repositório
git clone https://github.com/SEU_USERNAME/github-badges-mastery.git
cd github-badges-mastery

# Instalar dependências (se houver)
npm install

# Configurar Git para co-autoria
git config commit.template .gitmessage
```

### 2. Tipos de Contribuição

#### 🦈 Pull Shark Contributions
- Criar branches temáticas
- Implementar features estruturadas
- Seguir padrões de commit

#### 👥 Pair Extraordinaire Contributions
- **SEMPRE** incluir co-autoria nos commits
- Usar o template de commit configurado
- Colaborar em features complexas

#### ⚙️ DevOps Guru Contributions
- Melhorar workflows existentes
- Criar novos GitHub Actions
- Otimizar automações

#### 🧠 Galaxy Brain Contributions
- Participar de discussões
- Propor melhorias via discussions
- Compartilhar conhecimento

### 3. Padrões de Desenvolvimento

#### Estrutura de Branches
```
main                    # Branch principal
├── feature/nome-da-feature    # Novas funcionalidades
├── fix/nome-do-bug           # Correções
├── docs/nome-da-doc          # Documentação
└── refactor/nome-refactor    # Refatorações
```

#### Padrões de Commit
Seguimos o padrão Conventional Commits com co-autoria obrigatória:

```bash
# Formato básico
git commit -m "tipo: descrição breve

Descrição mais detalhada se necessário.

Co-authored-by: GitHub Copilot <copilot@github.com>
Co-authored-by: Seu Nome <seu@email.com>"
```

**Tipos de commit:**
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `test:` - Testes
- `refactor:` - Refatoração
- `style:` - Formatação
- `ci:` - CI/CD
- `chore:` - Tarefas de manutenção

#### Exemplos de Commits Válidos

```bash
# Feature com co-autoria
git commit -m "feat: adicionar monitor de progresso de badges

Implementa script para monitorar automaticamente o progresso
das insígnias conquistadas, incluindo relatórios detalhados.

Co-authored-by: GitHub Copilot <copilot@github.com>"

# Fix com co-autoria
git commit -m "fix: corrigir contagem de PRs no monitor

Corrige bug onde PRs merged não eram contabilizados
corretamente no script de monitoramento.

Co-authored-by: Assistant <assistant@badges-mastery.com>"

# Documentação com co-autoria
git commit -m "docs: atualizar guia de contribuição

Adiciona seção sobre padrões de commit e co-autoria
para facilitar contribuições futuras.

Co-authored-by: Documentation Bot <docs@badges-mastery.com>"
```

### 4. Processo de Pull Request

#### Antes de Criar o PR
```bash
# Atualizar branch principal
git checkout main
git pull origin main

# Criar nova branch
git checkout -b feature/sua-feature

# Fazer mudanças e commits com co-autoria
git add .
git commit -m "feat: sua feature

Co-authored-by: GitHub Copilot <copilot@github.com>"

# Push da branch
git push origin feature/sua-feature
```

#### Criando o PR
```bash
# Via GitHub CLI (recomendado)
gh pr create \
  --title "feat: sua feature" \
  --body "Descrição detalhada da feature e como ela contribui para as badges"

# Ou via interface web do GitHub
```

#### Template de PR
```markdown
## 🎯 Objetivo
Descreva o objetivo desta mudança e como ela contribui para as badges.

## 🏆 Badges Impactadas
- [ ] 🦈 Pull Shark
- [ ] 👥 Pair Extraordinaire  
- [ ] ⚙️ DevOps Guru
- [ ] 🧠 Galaxy Brain
- [ ] ⚡ Quickdraw
- [ ] ❤️ Heart On Your Sleeve
- [ ] 🎲 YOLO

## 🔄 Mudanças Realizadas
- Lista das principais mudanças
- Arquivos modificados
- Funcionalidades adicionadas

## 🧪 Testes
- [ ] Testes passando
- [ ] Funcionalidade testada manualmente
- [ ] Documentação atualizada

## 📋 Checklist
- [ ] Commits seguem padrão com co-autoria
- [ ] Branch atualizada com main
- [ ] Testes passando
- [ ] Documentação atualizada
```

### 5. Estratégias Específicas por Badge

#### 🦈 Pull Shark Strategy
- Criar PRs pequenos e focados
- Usar branches descritivas
- Fazer merge após review (mesmo que seja self-review)

#### 👥 Pair Extraordinaire Strategy
- **OBRIGATÓRIO:** Co-autoria em todos os commits
- Usar diferentes co-autores para variedade
- Documentar colaborações

#### ⚙️ DevOps Guru Strategy
- Contribuir com workflows
- Melhorar automações existentes
- Criar novos GitHub Actions

#### 🧠 Galaxy Brain Strategy
- Participar de discussions
- Propor melhorias via discussions
- Responder perguntas da comunidade

#### ⚡ Quickdraw Strategy
- Criar issues rapidamente via automação
- Usar templates para agilizar
- Responder issues em menos de 5 minutos

#### ❤️ Heart On Your Sleeve Strategy
- Reagir a issues e PRs
- Usar emojis de forma consistente
- Engajar com a comunidade

#### 🎲 YOLO Strategy
- Fazer merges diretos quando apropriado
- Usar em branches de desenvolvimento
- Documentar decisões de merge

### 6. Ferramentas Recomendadas

#### GitHub CLI
```bash
# Instalar GitHub CLI
# Windows: winget install GitHub.cli
# Mac: brew install gh
# Linux: apt install gh

# Configurar
gh auth login

# Aliases úteis
gh alias set pr-quick 'pr create --title "feat: " --body "Quick feature implementation"'
gh alias set issue-quick 'issue create --title "📋 " --body "Quick issue creation"'
```

#### Scripts Úteis
```bash
# Executar monitor de badges
npm run badges

# Executar testes
npm test

# Executar setup inicial
npm run setup
```

### 7. Diretrizes de Qualidade

#### Code Review
- Revisar próprios PRs antes de merge
- Verificar se commits têm co-autoria
- Testar funcionalidades localmente

#### Documentação
- Atualizar README quando necessário
- Documentar novas estratégias
- Manter exemplos atualizados

#### Testes
- Executar testes antes de commit
- Adicionar testes para novas features
- Manter cobertura de testes

### 8. Comunicação

#### Issues
- Usar templates fornecidos
- Ser específico sobre o problema
- Incluir contexto sobre badges

#### Discussions
- Participar ativamente
- Compartilhar estratégias
- Ajudar outros contribuidores

#### PRs
- Descrições claras e detalhadas
- Explicar impacto nas badges
- Responder feedback rapidamente

## 🎉 Reconhecimento

Contribuidores ativos serão reconhecidos:
- Menção no README principal
- Co-autoria em commits importantes
- Participação em discussions destacadas

## 📞 Suporte

- **Issues:** Para bugs e problemas técnicos
- **Discussions:** Para dúvidas e ideias
- **Email:** badges@mastery.com (se configurado)

---

**Lembre-se:** O objetivo é conquistar badges de forma ética e educativa, criando valor real através do processo!

**Última atualização:** $(date)  
**Versão:** 1.0.0
