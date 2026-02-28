# GitHub + OpenCode 完整集成指南

**配置时间**: 2026-02-28 01:55 GMT+8  
**状态**: 已访问 GitHub 主页，准备创建仓库

---

## 📋 配置流程总览

### ✅ 步骤 1: 访问 GitHub 主页
- 已在浏览器中打开：https://github.com
- 下一步：登录账户

### ⏳ 步骤 2: 创建新仓库
- 仓库名称：`opencode-demo` 或 `code-review-automation`
- 可见性：公开或私有
- 初始化选项：README + .gitignore + License

### ⏳ 步骤 3: 安装 OpenCode GitHub App
- 访问：https://github.com/apps/opencode-agent
- 授权目标仓库

### ⏳ 步骤 4: 配置 GitHub Action 工作流
- 创建 `.github/workflows/opencode.yml`
- 配置 API 密钥到 Secrets

### ⏳ 步骤 5: 测试集成
- 在 Issue/PR 中使用 `/opencode` 命令
- 验证自动代码审查

---

## 🔧 详细配置说明

### 1. 创建 GitHub 仓库

**仓库名称建议**:
- `opencode-demo` - 演示用途
- `code-review-automation` - 自动审查
- `my-project-with-ai-review` - 个人项目

**仓库配置**:
```
Repository name: opencode-demo
Description: Demo project with OpenCode integration
Visibility: Public (或 Private)
☑ Add a README file
☑ Add .gitignore: Python (或 Node.js)
☑ Choose a license: MIT
```

---

### 2. OpenCode GitHub App 安装

**访问**: https://github.com/apps/opencode-agent

**权限要求**:
- ✅ Contents: read & write
- ✅ Issues: read & write  
- ✅ Pull requests: read & write
- ✅ Metadata: read

**安装范围**:
- 选择刚创建的仓库 (`opencode-demo`)
- 或授权所有仓库

---

### 3. GitHub Action 工作流配置

#### 3.1 基础代码审查工作流

创建 `.github/workflows/opencode.yml`:

```yaml
name: OpenCode Code Review

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
          # 使用本地大模型 API
          OPENAI_API_KEY: ${{ secrets.LOCAL_MODEL_API_KEY }}
          OPENAI_BASE_URL: http://118.252.19.92:44331/v1
        with:
          # 使用 Qwen3.5 模型
          model: openai/Qwen3.5-397B-A17B-UD-Q4_K_XL
          # 自定义审查提示词（可选）
          prompt: |
            Review this code for:
            - Code quality and best practices
            - Potential bugs and security issues
            - Performance optimization opportunities
            - Clear and maintainable code structure
            
            Provide constructive feedback with specific examples.
```

---

#### 3.2 定时审查工作流

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
            - TODO comments needing attention
            - Code smells and technical debt
            - Security vulnerabilities
            - Performance bottlenecks
            
            Create issues for critical findings.
```

---

#### 3.3 PR 自动审查工作流

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

### 4. 配置 API Secrets

**步骤**:
1. 进入仓库 Settings
2. 左侧菜单：Secrets and variables → Actions
3. 点击 "New repository secret"

**添加以下 Secret**:

| Secret Name | Secret Value |
|------------|-------------|
| `LOCAL_MODEL_API_KEY` | 您的 API 密钥（如果需要认证） |
| `OPENAI_BASE_URL` | `http://118.252.19.92:44331/v1` |

---

### 5. 使用方式

#### 5.1 在 Issue 中评论

```
/opencode explain this issue
```

**响应**:
- OpenCode 阅读整个讨论串
- 回复清晰的解释
- 提供相关文档链接

#### 5.2 在 PR 中评论

```
/opencode review this PR
```

**响应**:
- 自动分析代码变更
- 提供改进建议
- 创建新的提交（如果请求修改）

#### 5.3 特定代码行审查

在 Files 选项卡中对特定代码行评论：

```
/opencode add error handling here
```

**响应**:
- 检测文件路径和行号
- 提供精准的代码建议
- 自动创建修复提交

#### 5.4 Issue 分类

自动分类新建的 Issue：

```yaml
name: Issue Triage

on:
  issues:
    types: [opened]

jobs:
  triage:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: write
      pull-requests: write
      issues: write
    
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      
      - uses: anomalyco/opencode/github@latest
        env:
          OPENAI_API_KEY: ${{ secrets.LOCAL_MODEL_API_KEY }}
          OPENAI_BASE_URL: http://118.252.19.92:44331/v1
        with:
          model: openai/Qwen3.5-397B-A17B-UD-Q4_K_XL
          prompt: |
            Review this issue. If there's a clear fix:
            - Provide documentation links
            - Add error handling guidance
            - Create fix if straightforward
```

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
- 确保模型支持 `chat/completions` 接口
- 配置正确的认证方式（如果需要）

### 网络访问

GitHub Actions 运行器需要能访问您的 API 端点：
- 确保 `http://118.252.19.92:44331` 可从 GitHub Actions 访问
- 考虑使用 HTTPS（推荐）
- 配置防火墙白名单（如果需要）

---

## 📊 配置检查清单

### 基础配置
- [ ] 创建 GitHub 仓库
- [ ] 安装 OpenCode GitHub App
- [ ] 添加工作流文件
- [ ] 配置 API Secrets
- [ ] 测试 `/opencode` 命令

### 高级配置（可选）
- [ ] 配置定时审查任务
- [ ] 设置 Issue 自动分类
- [ ] 启用 PR 自动审查
- [ ] 自定义提示词模板

---

## 🎯 快速开始脚本

### 创建工作流的快捷方式

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/opencode-demo.git
cd opencode-demo

# 2. 创建目录结构
mkdir -p .github/workflows

# 3. 添加工作流文件
# 复制上面的配置内容到 .github/workflows/opencode.yml

# 4. 提交并推送
git add .
git commit -m "Add OpenCode integration"
git push origin main
```

### 测试集成

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

## 📝 下一步操作

### 在浏览器中手动操作：

1. **登录 GitHub** (已在浏览器中打开)
2. **创建新仓库**:
   - 点击右上角 "+" → "New repository"
   - 输入仓库名称：`opencode-demo`
   - 选择可见性
   - 勾选初始化选项
   - 点击 "Create repository"

3. **安装 OpenCode App**:
   - 访问：https://github.com/apps/opencode-agent
   - 点击 "Install"
   - 选择刚创建的仓库

4. **添加工作流**:
   - 在仓库中创建 `.github/workflows/` 目录
   - 添加 `opencode.yml` 文件
   - 复制上面的配置内容

5. **配置 Secrets**:
   - Settings → Secrets and variables → Actions
   - 添加 API 密钥

---

**配置时间**: 2026-02-28 01:55 GMT+8  
**API 端点**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL  
**状态**: 已访问 GitHub，等待登录创建仓库

---

## 💡 提示

您现在可以：
1. 在 GitHub 主页登录账户
2. 按照上述步骤创建仓库
3. 配置 OpenCode 集成
4. 测试 `/opencode` 命令

需要我继续协助哪个步骤？