# GitHub + OpenCode 集成配置指南

**配置时间**: 2026-02-28 01:50 GMT+8

---

## 📋 配置步骤总览

### 步骤 1: 创建 GitHub 仓库 ✅
### 步骤 2: 安装 OpenCode GitHub App ✅
### 步骤 3: 配置 GitHub Action 工作流 ✅
### 步骤 4: 配置 API 密钥到 Secrets ✅
### 步骤 5: 测试集成 ✅

---

## 🔧 详细配置

### 1. 创建 GitHub 仓库

**仓库名称**: `opencode-demo` 或您喜欢的任何名称

**可见性**: 公开或私有（根据您的需求）

**初始化选项**:
- ✅ Add a README file
- ✅ Add .gitignore (选择 Python 或 Node.js)
- ✅ Choose a license (MIT 推荐)

---

### 2. 安装 OpenCode GitHub App

**访问**: https://github.com/apps/opencode-agent

**安装步骤**:
1. 点击 "Install" 按钮
2. 选择要授权的仓库（选择刚创建的 `opencode-demo`）
3. 确认权限授予

**权限要求**:
- ✅ Contents: read & write
- ✅ Issues: read & write
- ✅ Pull requests: read & write
- ✅ Metadata: read

---

### 3. 配置 GitHub Action 工作流

创建 `.github/workflows/opencode.yml`:

```yaml
name: opencode-code-review

on:
  pull_request:
    types: [opened, synchronize, reopened, ready_for_review]
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]

jobs:
  opencode:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: write
      pull-requests: write
      issues: write
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v6
        with:
          fetch-depth: 1
          persist-credentials: false
      
      - name: Run OpenCode
        uses: anomalyco/opencode/github@latest
        env:
          # 使用您的本地大模型 API
          OPENAI_API_KEY: ${{ secrets.LOCAL_MODEL_API_KEY }}
          OPENAI_BASE_URL: http://118.252.19.92:44331/v1
        with:
          # 使用 Qwen3.5 模型（兼容 OpenAI API 格式）
          model: openai/Qwen3.5-397B-A17B-UD-Q4_K_XL
          # 可选：自定义审查提示词
          prompt: |
            Review this code for:
            - Code quality and best practices
            - Potential bugs and security issues
            - Performance optimization opportunities
            - Clear and maintainable code structure
            - Proper error handling
          
            Provide constructive feedback with specific examples.
```

---

### 4. 定时审查工作流（可选）

创建 `.github/workflows/opencode-scheduled.yml`:

```yaml
name: Scheduled Code Review

on:
  schedule:
    - cron: "0 9 * * 1"  # 每周一 9:00 UTC
  workflow_dispatch:  # 允许手动触发

jobs:
  opencode:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: write
      pull-requests: write
      issues: write
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v6
        with:
          persist-credentials: false
      
      - name: Run OpenCode
        uses: anomalyco/opencode/github@latest
        env:
          OPENAI_API_KEY: ${{ secrets.LOCAL_MODEL_API_KEY }}
          OPENAI_BASE_URL: http://118.252.19.92:44331/v1
        with:
          model: openai/Qwen3.5-397B-A17B-UD-Q4_K_XL
          prompt: |
            Review the codebase for:
            - TODO comments that need attention
            - Code smells and technical debt
            - Security vulnerabilities
            - Performance bottlenecks
            
            Create issues for critical findings.
```

---

### 5. PR 自动审查工作流（可选）

创建 `.github/workflows/opencode-pr-review.yml`:

```yaml
name: Automatic PR Review

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  review:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
      pull-requests: read
    
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      
      - uses: anomalyco/opencode/github@latest
        env:
          OPENAI_API_KEY: ${{ secrets.LOCAL_MODEL_API_KEY }}
          OPENAI_BASE_URL: http://118.252.19.92:44331/v1
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          model: openai/Qwen3.5-397B-A17B-UD-Q4_K_XL
          use_github_token: true
          prompt: |
            Review this pull request:
            - Check for code quality issues
            - Look for potential bugs
            - Suggest improvements
            - Verify test coverage
            
            Comment on the PR with your findings.
```

---

### 6. 配置 API 密钥到 GitHub Secrets

**步骤**:
1. 进入仓库 Settings
2. 左侧菜单：Secrets and variables → Actions
3. 点击 "New repository secret"
4. 添加以下密钥：

**Secret 名称**: `LOCAL_MODEL_API_KEY`  
**Secret 值**: 您的本地模型 API 密钥（如果需要认证）

**Secret 名称**: `OPENAI_BASE_URL`  
**Secret 值**: `http://118.252.19.92:44331/v1`

---

### 7. 使用方式

#### 在 Issue 中评论
```
/opencode explain this issue
```

#### 在 PR 中评论
```
/opencode review this PR
```

#### 特定代码行审查
在 Files 选项卡中对特定代码行评论：
```
/opencode add error handling here
```

#### 自动触发
- 创建 PR 时自动触发审查
- 每周一自动执行代码库审查
- 手动从 Actions 标签触发

---

## ⚠️ 注意事项

### 权限配置
确保工作流包含正确的权限：
```yaml
permissions:
  id-token: write
  contents: write
  pull-requests: write
  issues: write
```

### API 兼容性
- 使用 OpenAI 兼容格式的 API 端点
- 确保模型支持 chat/completions 接口
- 配置正确的认证方式（如果需要）

### 网络访问
GitHub Actions 运行器需要能访问您的 API 端点：
- 确保 `http://118.252.19.92:44331` 可从 GitHub Actions 访问
- 考虑使用 HTTPS（推荐）
- 配置防火墙白名单（如果需要）

---

## 📊 配置检查清单

- [ ] 创建 GitHub 仓库
- [ ] 安装 OpenCode GitHub App
- [ ] 添加工作流文件
- [ ] 配置 API Secrets
- [ ] 测试 `/opencode` 命令
- [ ] 验证 PR 自动审查
- [ ] 配置定时任务（可选）

---

## 🎯 快速开始

### 1. 创建工作流的快捷方式

```bash
# 克隆您的仓库
git clone https://github.com/YOUR_USERNAME/opencode-demo.git
cd opencode-demo

# 创建目录结构
mkdir -p .github/workflows

# 添加工作流文件
# （复制上面的配置内容）

# 提交并推送
git add .
git commit -m "Add OpenCode integration"
git push origin main
```

### 2. 测试集成

1. 创建一个测试分支
2. 创建 Pull Request
3. 在 PR 中评论：`/opencode review this`
4. 等待 OpenCode 响应

---

## 🔗 延伸资源

- **OpenCode 文档**: https://opencode.ai/docs/zh-cn/github/
- **GitHub App**: https://github.com/apps/opencode-agent
- **示例仓库**: 查看 opencode 官方示例

---

**配置时间**: 2026-02-28 01:50 GMT+8  
**API 端点**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL