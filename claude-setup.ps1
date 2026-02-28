# Claude Code CLI 安装验证和 PATH 设置脚本

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Claude Code CLI 安装验证" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# 检查 npm 全局包
Write-Host "`n[1] 检查 npm 全局安装..." -ForegroundColor Yellow
npm list -g @anthropic-ai/claude-code

# 获取 npm 全局路径
Write-Host "`n[2] 获取 npm 全局路径..." -ForegroundColor Yellow
$npmPrefix = npm config get prefix
$claudePath = "$npmPrefix"

Write-Host "npm 全局路径：$claudePath" -ForegroundColor Green

# 检查当前用户 PATH
Write-Host "`n[3] 检查 PATH 环境变量..." -ForegroundColor Yellow
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($userPath -notlike "*$claudePath*") {
    Write-Host "添加 npm 路径到 PATH..." -ForegroundColor Yellow
    $newPath = "$claudePath;$userPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "✓ 已更新用户 PATH 环境变量" -ForegroundColor Green
} else {
    Write-Host "✓ npm 路径已在 PATH 中" -ForegroundColor Green
}

# 刷新当前会话的 PATH
$env:Path = "$claudePath;$env:Path"

# 验证 claude 命令
Write-Host "`n[4] 验证 claude 命令..." -ForegroundColor Yellow
try {
    $claudeVersion = & "$claudePath\claude.cmd" --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Claude Code CLI 安装成功!" -ForegroundColor Green
        Write-Host "版本信息：$claudeVersion" -ForegroundColor Green
    } else {
        Write-Host "✗ claude 命令执行失败" -ForegroundColor Red
        Write-Host "错误：$claudeVersion" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ 未找到 claude 命令" -ForegroundColor Red
    Write-Host "错误信息：$_" -ForegroundColor Red
}

Write-Host "`n====================================" -ForegroundColor Cyan
Write-Host "配置摘要" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "npm 路径：$claudePath"
Write-Host "配置文件：C:\Users\zhang\.claude\config.json"
Write-Host "API 端点：http://118.252.19.92:44331/v1"
Write-Host "模型：Qwen3.5-397B-A17B-UD-Q4_K_XL"
Write-Host "`n====================================" -ForegroundColor Cyan

Write-Host "`n[提示] 如果 claude 命令仍然不可用，请:" -ForegroundColor Yellow
Write-Host "1. 关闭当前 PowerShell 窗口" -ForegroundColor White
Write-Host "2. 重新打开一个新的 PowerShell 窗口" -ForegroundColor White
Write-Host "3. 运行：claude --version" -ForegroundColor White

Write-Host "`n[5] 测试 API 连接..." -ForegroundColor Yellow
try {
    $apiResponse = Invoke-RestMethod -Uri "http://118.252.19.92:44331/v1/models" -TimeoutSec 10 -ErrorAction Stop
    Write-Host "✓ API 端点可访问" -ForegroundColor Green
    Write-Host "模型列表：$($apiResponse.data.Count) 个模型" -ForegroundColor Green
} catch {
    Write-Host "⚠ API 端点连接失败" -ForegroundColor Yellow
    Write-Host "错误：$_" -ForegroundColor Yellow
}

Write-Host "`n完成!" -ForegroundColor Cyan