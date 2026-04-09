# GSD Custom Fork Playbook

This file is the step-by-step guide for installing this fork into any project and for improving this fork with changes you discover elsewhere.

## Part A: Install This Fork Into Any Project

1. Open your target project folder.
2. Run `/install` (recommended). This uses `.agent/workflows/install.md` and installs from this fork.
3. Then run `/new-project` and follow the prompts.

### Manual install (PowerShell)

```powershell
# Open your project
cd your-project

# Clone this fork (with submodules)
git clone --depth 1 --recurse-submodules https://github.com/nposadaa/get-shit-done-for-antigravity_NicksDev .gsd-install-temp

# Copy core directories
Copy-Item -Recurse .gsd-install-temp\.agent .\
Copy-Item -Recurse .gsd-install-temp\.agents .\
Copy-Item -Recurse .gsd-install-temp\.gemini .\
Copy-Item -Recurse .gsd-install-temp\.gsd .\
Copy-Item -Recurse .gsd-install-temp\adapters .\
Copy-Item -Recurse .gsd-install-temp\docs .\
Copy-Item -Recurse .gsd-install-temp\scripts .\

# Copy root files
Copy-Item -Force .gsd-install-temp\PROJECT_RULES.md .\
Copy-Item -Force .gsd-install-temp\GSD-STYLE.md .\
Copy-Item -Force .gsd-install-temp\model_capabilities.yaml .\

# Clean up
Remove-Item -Recurse -Force .gsd-install-temp
```

## Part B: Improve This Fork With New Lessons

Use this whenever you learn new rules, add tools, or tweak workflows.

### Transfer newly learned rules from a project into this fork

When a project reveals a new rule or preference, copy it into this fork so it becomes part of future installs.

1. In the project where you learned the rule, open `PROJECT_RULES.md` and add the new rule there first.
2. Copy the new rule text (or note the section you added).
3. Open the fork repo and paste the rule into its `PROJECT_RULES.md` in the appropriate section.
4. Commit and push the fork so the rule becomes part of the next install.

PowerShell example (copy rule lines from a project into the fork):

```powershell
# In the project where you learned the rule:
Get-Content .\PROJECT_RULES.md

# In the fork repo:
cd C:\Users\nposa\IT_Projects\GSD_NicksDev\get-shit-done-for-antigravity_NicksDev
notepad .\PROJECT_RULES.md
# Paste the new rule(s), save, then commit and push.
```

1. Go to the fork repo root:

```powershell
cd C:\Users\nposa\IT_Projects\GSD_NicksDev\get-shit-done-for-antigravity_NicksDev
```

2. Confirm you are at the repo root:

```powershell
git rev-parse --show-toplevel
```

3. Update rules and workflows:
- Add hard-won lessons to `PROJECT_RULES.md`.
- Update `.agent/workflows/*.md` as needed.
- If you add new skills, put them in `.agents/skills/` as submodules (see below).

4. Add or update skill submodules:

```powershell
# Add new skill submodule
git submodule add <REPO_URL> .agents/skills/<skill-name>

# Update existing submodules to latest
# (review changes before committing)
git submodule update --remote --merge
```

5. Commit and push:

```powershell
git add .
git commit -m "feat: update fork rules and workflows"
git push
```

## Part C: Update GSD in an Existing Project to the Latest Fork

Use this when a project already has GSD installed and you want to refresh it with your newest fork.

1. In the project that needs updating, run `/update`.
2. Confirm the update when prompted.

This uses `.agent/workflows/update.md`, which already points to this fork and pulls submodules.

### Manual update (PowerShell)

```powershell
# Open your project
cd your-project

# Pull latest fork (with submodules)
git clone --depth 1 --recurse-submodules https://github.com/nposadaa/get-shit-done-for-antigravity_NicksDev .gsd-update-temp

# Backup current
Copy-Item -Recurse ".agent" ".agent.backup"
Copy-Item -Recurse ".agents" ".agents.backup"
Copy-Item -Recurse ".gsd\\templates" ".gsd\\templates.backup"

# Update workflows (preserve user's .gsd docs)
Copy-Item -Recurse -Force ".gsd-update-temp\\.agent\\*" ".agent\\"

# Update skills
Copy-Item -Recurse -Force ".gsd-update-temp\\.agents\\*" ".agents\\"

# Update templates only
Copy-Item -Recurse -Force ".gsd-update-temp\\.gsd\\templates\\*" ".gsd\\templates\\"

# Update root files
Copy-Item -Force ".gsd-update-temp\\GSD-STYLE.md" ".\\"
Copy-Item -Force ".gsd-update-temp\\CHANGELOG.md" ".\\"
Copy-Item -Force ".gsd-update-temp\\PROJECT_RULES.md" ".\\"
Copy-Item -Force ".gsd-update-temp\\VERSION" ".\\"

# Clean up
Remove-Item -Recurse -Force ".gsd-update-temp"
Remove-Item -Recurse -Force ".agent.backup"
Remove-Item -Recurse -Force ".agents.backup"
Remove-Item -Recurse -Force ".gsd\\templates.backup"
```

## Troubleshooting

- If you see `fatal: not a git repository`, you are not inside the fork repo root.
- If `git submodule add` fails because a path already exists, remove the folder first:

```powershell
Remove-Item -Recurse -Force .agents\skills\<skill-name>
```

## Reference

Upstream GSD baseline:
- `https://github.com/glittercowboy/get-shit-done`
