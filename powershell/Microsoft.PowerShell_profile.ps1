$starshipCachePath = "$env:LOCALAPPDATA\starship_init.ps1"
if (-not (Test-Path $starshipCachePath) -or (Get-Command starship -ErrorAction SilentlyContinue).Source -gt (Get-Item $starshipCachePath -ErrorAction SilentlyContinue).LastWriteTime) {
    & starship init powershell | Out-File -FilePath $starshipCachePath -Encoding utf8
}
. $starshipCachePath

Set-PSReadLineOption -EditMode Emacs

Import-Module PSFzf -ErrorAction SilentlyContinue
if (-not $?) {
    Write-Host "Install PSFzf..." -ForegroundColor Cyan
    Install-Module -Name PSFzf -Scope CurrentUser -Force -SkipPublisherCheck
    Import-Module PSFzf
}

Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSFzfOption -TabExpansion
Set-PSFzfOption -TabCompletionPreviewWindow 'hidden|right|down|hidden'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

