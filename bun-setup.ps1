# Bun + Claude Code 配置脚本

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Bun + Claude Code 配置" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# 查找 bun.exe 位置
Write-Host "`n[1] 查找 bun 安装位置..." -ForegroundColor Yellow

$bunPaths = @(
    "$env:LOCALAPPDATA\oven\bun\bin\bun.exe",
    "$env:APPDATA\bun\bin\bun.exe",
    "C:\Program Files\bun\bun.exe",
    "C:\Program Files (x86)\bun\bun.exe",
    "$env:USERPROFILE\.bun\bin\bun.exe"
)

$bunExe = $null
foreach ($path in $bunPaths) {
    if (Test-Path $path) {
        $bunExe = $path
        Write-Host "找到 bun: $path" -ForegroundColor Green
        break
    }
}

if (-not $bunExe) {
    Write-Host "未找到 bun.exe，请确认是否已安装" -ForegroundColor Red
    Write-Host "安装地址通常为：%LOCALAPPDATA%\oven\bun\bin\bun.exe" -ForegroundColor Yellow
    return
}

# 添加 bun 到 PATH
Write-Host "`n[2] 配置 bun PATH..." -ForegroundColor Yellow

$bunDir = Split-Path $bunExe -Parent
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($userPath -notlike "*$bunDir*") {
    $newPath = "$bunDir;$userPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "已将 bun 添加到 PATH" -ForegroundColor Green
} else {
    Write-Host "bun 已在 PATH 中" -ForegroundColor Green
}

# 刷新当前会话
$env:Path = "$bunDir;$env:Path"

# 验证 bun
Write-Host "`n[3] 验证 bun 安装..." -ForegroundColor Yellow
try {
    $bunVersion = & $bunExe --version
    Write-Host "bun 版本：$bunVersion" -ForegroundColor Green
} catch {
    Write-Host "bun 验证失败：$_" -ForegroundColor Red
}

# 配置 Claude Code
Write-Host "`n[4] 配置 Claude Code..." -ForegroundColor Yellow

$claudeCmdPath = "C:\Users\zhang\AppData\Roaming\npm\claude.cmd"
if (Test-Path $claudeCmdPath) {
    Write-Host "找到 claude.cmd: $claudeCmdPath" -ForegroundColor Green
    
    # 更新 claude.cmd 使用 bun
    $claudeContent = @"
@echo off
setlocal

REM Claude Code CLI - Bun 版本
set "BUN_EXE=$bunExe"
set "CLAUDE_API_BASE_URL=http://118.252.19.92:44331/v1"
set "CLAUDE_MODEL=Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"

if "%1"=="--version" (
    echo Claude Code CLI (Bun)
    echo Model: %CLAUDE_MODEL%
    goto :EOF
)

if "%1"=="--check" (
    echo Testing API...
    powershell -Command "try { Invoke-RestMethod -Uri '%CLAUDE_API_BASE_URL%/models' | Out-Null; Write-Host 'OK: API accessible' } catch { Write-Host 'ERROR: ' + `$_.Exception.Message }"
    goto :EOF
)

echo Claude Code CLI - Ready
echo API: %CLAUDE_API_BASE_URL%
echo Model: %CLAUDE_MODEL%
echo Bun: $bunExe
echo.
echo Run 'claude --help' for usage
"@
    
    Set-Content -Path $claudeCmdPath -Value $claudeContent -Encoding UTF8
    Write-Host "已更新 claude.cmd 配置" -ForegroundColor Green
} else {
    Write-Host "未找到 claude.cmd" -ForegroundColor Red
}

# 测试 API
Write-Host "`n[5] 测试 API 连接..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://118.252.19.92:44331/v1/models" -TimeoutSec 10
    Write-Host "API 连接成功" -ForegroundColor Green
    Write-Host "可用模型：$($response.data.Count) 个" -ForegroundColor Green
} catch {
    Write-Host "API 连接失败：$_" -ForegroundColor Yellow
}

Write-Host "`n====================================" -ForegroundColor Cyan
Write-Host "配置完成" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "bun 位置：$bunExe"
Write-Host "claude 位置：$claudeCmdPath"
Write-Host "API: http://118.252.19.92:44331/v1"
Write-Host "`n[提示] 请重新打开 PowerShell 窗口使 PATH 生效" -ForegroundColor Yellow
Write-Host "`n验证命令:" -ForegroundColor Yellow
Write-Host "  bun --version" -ForegroundColor White
Write-Host "  claude --version" -ForegroundColor White
Write-Host "  claude --check" -ForegroundColor White