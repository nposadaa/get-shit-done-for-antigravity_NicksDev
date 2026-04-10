<#
.SYNOPSIS
    Syncs this fork with the upstream GSD repository (glittercowboy/get-shit-done).
    
.DESCRIPTION
    This script ensures the 'upstream' remote is configured, fetches the latest
    changes, and provides guidance on merging while protecting custom "learnings".
#>

$upstreamUrl = "https://github.com/glittercowboy/get-shit-done.git"
$currentBranch = git rev-parse --abbrev-ref HEAD

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host " GSD FORK ► SYNC UPSTREAM" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

# 1. Check for upstream remote
$remotes = git remote
if ($remotes -notcontains "upstream") {
    Write-Host "[+] Adding upstream remote: $upstreamUrl" -ForegroundColor Gray
    git remote add upstream $upstreamUrl
}

# 2. Fetch latest
Write-Host "[+] Fetching latest from upstream..." -ForegroundColor Gray
git fetch upstream

# 3. Guidance
Write-Host ""
Write-Host "To bring upstream changes into your fork, run:" -ForegroundColor White
Write-Host "  git merge upstream/main" -ForegroundColor Yellow
Write-Host ""
Write-Host "IMPORTANT: After merging, carefully review 'PROJECT_RULES.md'." -ForegroundColor Magenta
Write-Host "Ensure that original GSD updates didn't overwrite your custom learnings." -ForegroundColor Magenta
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
