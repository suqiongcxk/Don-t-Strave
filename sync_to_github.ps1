param(
    [switch]$Pull,
    [switch]$Push
)

$ErrorActionPreference = 'Stop'
$repoUrl = 'https://github.com/suqiongcxk/Don-t-Strave.git'
$branch = 'main'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git for Windows was not found. Install Git and run this script again.'
}

if (-not (Test-Path (Join-Path (Get-Location) '.git'))) {
    git init
    git branch -M $branch
    git remote add origin $repoUrl
}
else {
    $origin = (git remote get-url origin 2>$null)
    if (-not $origin) { git remote add origin $repoUrl }
    elseif ($origin.Trim() -ne $repoUrl) { git remote set-url origin $repoUrl }
}

if (-not (git config user.name)) { git config user.name 'DST Save Sync' }
if (-not (git config user.email)) { git config user.email 'dst-save-sync@users.noreply.github.com' }

if ($Pull) {
    git pull --rebase origin $branch
}

git add -A
$pending = git status --porcelain
if ($pending) {
    git commit -m ('Sync DST save ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
}

$remoteMain = git ls-remote --heads origin $branch
if ($remoteMain) {
    git fetch origin $branch
    $common = git merge-base HEAD ('origin/' + $branch) 2>$null
    if (-not $common) {
        git merge ('origin/' + $branch) --allow-unrelated-histories --no-edit
    }
}

if (-not $Pull -or $Push) {
    git push -u origin $branch
}

Write-Host 'Sync complete.'
