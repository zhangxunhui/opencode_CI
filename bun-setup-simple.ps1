Write-Host "Bun + Claude Code Setup" -ForegroundColor Cyan

# Find bun
Write-Host "Finding bun..." -ForegroundColor Yellow
$bunExe = "C:\Users\zhang\AppData\Local\oven\bun\bin\bun.exe"

if (Test-Path $bunExe) {
    Write-Host "Found: $bunExe" -ForegroundColor Green
} else {
    Write-Host "bun not found at expected location" -ForegroundColor Red
    exit
}

# Add to PATH
$bunDir = Split-Path $bunExe -Parent
Write-Host "Adding $bunDir to PATH..." -ForegroundColor Yellow

[Environment]::SetEnvironmentVariable("Path", 
    "$bunDir;" + [Environment]::GetEnvironmentVariable("Path", "User"), 
    "User")

Write-Host "Done! Restart PowerShell to apply changes." -ForegroundColor Green
Write-Host "bun --version" -ForegroundColor White
Write-Host "claude --version" -ForegroundColor White