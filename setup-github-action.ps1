# PowerShell 脚本：一键配置 GitHub Actions + OpenCode 代码审查
# Usage: .\setup-github-action.ps1 -RepoPath "C:\path\to\your\repo"

param(
    [Parameter(Mandatory=$true)]
    [string]$RepoPath,
    
    [Parameter(Mandatory=$false)]
    [string]$OpenCodeApiKey
)

Write-Host "🚀 开始配置 GitHub Actions + OpenCode 代码审查" -ForegroundColor Cyan
Write-Host ""

# 验证仓库路径
if (-not (Test-Path $RepoPath)) {
    Write-Host "❌ 错误：仓库路径不存在：$RepoPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ 仓库路径：$RepoPath" -ForegroundColor Green

# 创建 .github/workflows 目录
$workflowDir = Join-Path $RepoPath ".github\workflows"
if (-not (Test-Path $workflowDir)) {
    Write-Host "📁 创建 workflows 目录..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $workflowDir -Force | Out-Null
    Write-Host "✅ 已创建：$workflowDir" -ForegroundColor Green
}

# 复制 workflow 文件
$workflowSource = "C:\Users\zhang\.openclaw\workspace\github-actions-opencode-review.yml"
$workflowDest = Join-Path $workflowDir "opencode-review.yml"

if (Test-Path $workflowSource) {
    Write-Host "📄 复制 workflow 文件..." -ForegroundColor Yellow
    Copy-Item $workflowSource $workflowDest -Force
    Write-Host "✅ 已创建：$workflowDest" -ForegroundColor Green
} else {
    Write-Host "❌ 错误：找不到 workflow 源文件" -ForegroundColor Red
    exit 1
}

# 检查 OpenCode API Key
if ($OpenCodeApiKey) {
    Write-Host "🔑 OpenCode API Key 已提供" -ForegroundColor Yellow
    Write-Host "⚠️ 请在 GitHub 仓库 Settings → Secrets and variables → Actions 中添加：" -ForegroundColor Yellow
    Write-Host "   OPENCODE_API_KEY = $OpenCodeApiKey" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠️ 配置步骤：" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1️⃣ 获取 OpenCode API Key：" -ForegroundColor Cyan
    Write-Host "   - 访问 OpenCode Zen 平台" -ForegroundColor White
    Write-Host "   - 登录并添加账单详情" -ForegroundColor White
    Write-Host "   - 复制 API Key" -ForegroundColor White
    Write-Host ""
    Write-Host "2️⃣ 在 GitHub 仓库添加 Secret：" -ForegroundColor Cyan
    Write-Host "   - 进入 Settings → Secrets and variables → Actions" -ForegroundColor White
    Write-Host "   - 点击 New repository secret" -ForegroundColor White
    Write-Host "   - Name: OPENCODE_API_KEY" -ForegroundColor White
    Write-Host "   - Value: 你的 API Key" -ForegroundColor White
    Write-Host ""
}

# 验证 git 仓库
$gitDir = Join-Path $RepoPath ".git"
if (Test-Path $gitDir) {
    Write-Host "✅ Git 仓库验证通过" -ForegroundColor Green
    
    # 检查是否有 .github 目录
    $githubDir = Join-Path $RepoPath ".github"
    if (Test-Path $githubDir) {
        Write-Host "✅ .github 目录已存在" -ForegroundColor Green
    }
    
    # 显示下一步操作
    Write-Host ""
    Write-Host "📋 下一步操作：" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. 提交 workflow 文件到仓库：" -ForegroundColor White
    Write-Host "   cd $RepoPath" -ForegroundColor Gray
    Write-Host "   git add .github/workflows/opencode-review.yml" -ForegroundColor Gray
    Write-Host "   git commit -m 'feat: add OpenCode code review workflow'" -ForegroundColor Gray
    Write-Host "   git push" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. 在 GitHub 添加 OPENCODE_API_KEY Secret" -ForegroundColor White
    Write-Host ""
    Write-Host "3. 创建一个测试 PR 验证配置" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "⚠️ 警告：$RepoPath 不是 git 仓库" -ForegroundColor Yellow
    Write-Host "   请先初始化 git 仓库或克隆现有仓库" -ForegroundColor White
}

Write-Host ""
Write-Host "✅ 配置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "📚 详细文档：C:\Users\zhang\.openclaw\workspace\GITHUB_ACTION_SETUP.md" -ForegroundColor Cyan
Write-Host ""