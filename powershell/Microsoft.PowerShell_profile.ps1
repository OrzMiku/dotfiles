Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key "Ctrl+LeftArrow" -Function BackwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+RightArrow" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+Backspace" -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key "Ctrl+w" -Function BackwardKillWord

Import-Module PSFzf -ErrorAction SilentlyContinue
if (Get-Module PSFzf) {
  Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}
else {
  Write-Host "Missing PSFzf..." -ForegroundColor Cyan
}


fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
$env:EDITOR = "nvim"
