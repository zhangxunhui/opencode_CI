# PowerShell 脚本：提交并推送 OpenCode CI 配置到 GitHub
# Usage: .\setup-push.ps1

Write-Host "🚀 开始配置 GitHub 仓库..." -ForegroundColor Cyan
Write-Host ""

# 验证 git
try {
    $gitVersion = git --version
    Write-Host "✅ Git 已安装：$gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误：未找到 git，请先安装 git" -ForegroundColor Red
    Write-Host "下载地址：https://git-scm.com/download" -ForegroundColor Yellow
    exit 1
}

# 设置仓库路径
$repoPath = "C:\Users\zhang\.openclaw\workspace\opencode_CI"
Set-Location $repoPath

Write-Host ""
Write-Host "📁 当前路径：$repoPath" -ForegroundColor Cyan
Write-Host ""

# 验证仓库结构
$files = @(
    "README.md",
    "CONFIG_SETUP.md",
    ".github\workflows\opencode-review.yml"
)

Write-Host "📋 验证文件..." -ForegroundColor Yellow
foreach ($file in $files) {
    $path = Join-Path $repoPath $file
    if (Test-Path $path) {
        Write-Host "  ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $file (缺失)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🔧 配置 git 用户信息..." -ForegroundColor Yellow

# 检查 git 配置
$gitUser = git config user.name 2>$null
$gitEmail = git config user.email 2>$null

if (-not $gitUser) {
    Write-Host "⚠️ 未设置 git user.name，请配置：" -ForegroundColor Yellow
    Write-Host "   git config user.name `"Your Name`"" -ForegroundColor Gray
    Write-Host ""
}

if (-not $gitEmail) {
    Write-Host "⚠️ 未设置 git user.email，请配置：" -ForegroundColor Yellow
    Write-Host "   git config user.email `"your@email.com`"" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
Write-Host "📤 准备提交文件..." -ForegroundColor Yellow

# 添加所有文件
git add .

# 显示变更
$status = git status --short
if ($status) {
    Write-Host ""
    Write-Host "📝 变更文件:" -ForegroundColor Cyan
    Write-Host $status -ForegroundColor Gray
    Write-Host ""
    
    # 提交
    Write-Host "🔨 提交配置..." -ForegroundColor Yellow
    git commit -m "feat: 初始化 OpenCode CI 配置

- 添加代码审查 workflow
- 配置 OpenCode Zen 集成
- 设置自动化 PR 审查
- 添加配置说明文档
"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 提交成功" -ForegroundColor Green
    } else {
        Write-Host "❌ 提交失败" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "⚠️ 没有检测到变更" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📤 推送到 GitHub..." -ForegroundColor Yellow

# 检查远程仓库
$remote = git remote -v
if (-not $remote) {
    Write-Host "⚠️ 未设置远程仓库，添加 origin..." -ForegroundColor Yellow
    git remote add origin https://github.com/zhangxunhui/opencode_CI.git
}

# 推送
Write-Host ""
Write-Host "🚀 推送到 GitHub..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 推送成功!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 下一步操作:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. 打开仓库: https://github.com/zhangxunhui/opencode_CI" -ForegroundColor White
    Write-Host ""
    Write-Host "2. 启用 Actions:" -ForegroundColor White
    Write-Host "   - 点击 Actions 标签" -ForegroundColor Gray
    Write-Host "   - 点击 Enable Actions" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. 添加 OPENCODE_API_KEY Secret:" -ForegroundColor White
    Write-Host "   - Settings → Secrets and variables → Actions" -ForegroundColor Gray
    Write-Host "   - New repository secret" -ForegroundColor Gray
    Write-Host "   - Name: OPENCODE_API_KEY" -ForegroundColor Gray
    Write-Host "   - Value: sk-kUMOUmxNjvTvkZjMPJGcuN6H1CpThRlDxbX0o23wHZX5vtWiywHpwkKGuk9TGxdR" -ForegroundColor Gray
    Write-Host ""
    Write-Host "4. 创建测试 PR 验证配置" -ForegroundColor White
    Write-Host ""
    Write-Host "📚 详细文档: CONFIG_SETUP.md" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "⚠️ 推送可能需要认证，请使用以下命令:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "git push -u origin main" -ForegroundColor Gray
    Write-Host ""
    Write-Host "如果提示认证，可以:" -ForegroundColor Yellow
    Write-Host "1. 使用 GitHub Personal Access Token" -ForegroundColor White
    Write-Host "2. 配置 SSH Key" -ForegroundColor White
    Write-Host "3. 使用 GitHub CLI (gh)" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "✅ 配置完成!" -ForegroundColor Green