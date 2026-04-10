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

Use this when a project already has GSD installed and you want to refresh it with your newest fork (which includes both original GSD updates and your custom learnings).

1. In the project that needs updating, run `/update_nicks`.
2. Confirm the update when prompted.

This uses `.agent/workflows/update_nicks.md`, which pulls from the NicksDev fork and applies consolidated improvements.

### Manual update (PowerShell)

```powershell
# Open your project
cd your-project

# Pull latest fork (with submodules)
git clone --depth 1 --recurse-submodules https://github.com/nposadaa/get-shit-done-for-antigravity_NicksDev .gsd-update-temp

# Backup sensitive areas
Copy-Item -Recurse ".agent" ".agent.backup"
Copy-Item -Recurse ".agents" ".agents.backup"

# Update workflows and skills
Copy-Item -Recurse -Force ".gsd-update-temp\.agent\*" ".agent\"
Copy-Item -Recurse -Force ".gsd-update-temp\.agents\*" ".agents\"

# Update core files (Golden Master)
Copy-Item -Force ".gsd-update-temp\PROJECT_RULES.md" ".\"
Copy-Item -Force ".gsd-update-temp\GSD-STYLE.md" ".\"
Copy-Item -Force ".gsd-update-temp\CHANGELOG.md" ".\"
Copy-Item -Force ".gsd-update-temp\VERSION" ".\"

# Clean up
Remove-Item -Recurse -Force ".gsd-update-temp"
Remove-Item -Recurse -Force ".agent.backup"
Remove-Item -Recurse -Force ".agents.backup"
```

## Scenario: Migrating from Standard GSD to this Fork

If your project currently uses the official GSD (`glittercowboy/get-shit-done`) and you want to switch to this fork:

1. **Verify your custom project state**: Ensure your `.gsd/` folder (SPEC, ROADMAP, etc.) is healthy.
2. **Run the manual install steps**: Follow the [Manual install (PowerShell)](#manual-install-powershell) steps from Part A. Because the clone URL points to this fork, it will overwrite the official GSD files with this fork's "Golden Master" versions.
3. **Adopt `/update_nicks`**: Once migrated, use `/update_nicks` for all future updates.

## Troubleshooting

- If you see `fatal: not a git repository`, you are not inside the fork repo root.
- If `git submodule add` fails because a path already exists, remove the folder first:

```powershell
Remove-Item -Recurse -Force .agents\skills\<skill-name>
```

## Reference

Upstream GSD baseline:
- `https://github.com/glittercowboy/get-shit-done`

## Part D: Create a New Release (Tag + Push)

Use this after changes are committed and `CHANGELOG.md` is updated.

1. Go to the fork repo root:

```powershell
cd C:\Users\nposa\IT_Projects\GSD_NicksDev\get-shit-done-for-antigravity_NicksDev
```

2. Tag the release (choose your version). Use an annotated tag with a short description:

```powershell
git tag -a 1.0.1 -m "Release 1.0.1: playbook + submodules + fork workflows"
```

3. Push commits and tags:

```powershell
git push
git push --tags
```

4. Create the GitHub release from the tag (GitHub UI).

## Part E: Sync Fork with Upstream GSD

Use this to bring in official improvements from the original GSD repository without losing your custom learnings.

### 1. Run the Sync Script
A helper script is provided to set up the upstream remote and fetch the latest changes.

```powershell
.\scripts\sync-upstream.ps1
```

### 2. Merge and Resolve Conflicts
Merge the upstream changes into your main branch.

```powershell
git merge upstream/main
```

> [!IMPORTANT]
> **Semantic Merge of PROJECT_RULES.md**: 
> If `PROJECT_RULES.md` has conflicts, ensure you preserve your custom rules. If original GSD updated a core rule, merge their improvements while keeping your "Structural learnings" and "Model-agnostic" formatting.

### 3. Verify and Push
After merging and resolving conflicts, verify the fork state:

```powershell
.\scripts\validate-all.ps1
```

Then commit and push:
```powershell
git add .
git commit -m "chore: sync with upstream GSD baseline"
git push
```
