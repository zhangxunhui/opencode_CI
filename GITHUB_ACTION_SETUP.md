# GitHub Actions + OpenCode 代码审查配置指南

## 📋 概述

本配置将 GitHub Actions 与 OpenCode Zen 集成，实现自动化的代码审查流程。

## 🔧 配置步骤

### 1️⃣ 在 GitHub 仓库中添加 Secrets

进入你的 GitHub 仓库 → Settings → Secrets and variables → Actions

添加以下 Secret：

```bash
OPENCODE_API_KEY=你的 OpenCode API Key
```

**获取 OpenCode API Key：**
1. 访问 OpenCode Zen 平台
2. 登录并添加账单详情
3. 在 Dashboard 中复制 API Key

### 2️⃣ 添加 Workflow 文件

将 `github-actions-opencode-review.yml` 复制到你的仓库：

```bash
# 在工作目录执行
cp github-actions-opencode-review.yml .github/workflows/

# 或者手动创建
mkdir -p .github/workflows
cp github-actions-opencode-review.yml .github/workflows/
```

### 3️⃣ 配置 Workflow 权限

确保仓库允许 Actions 写入权限：

1. 进入仓库 Settings → Actions → General
2. 在 "Workflow permissions" 中选择：
   - ✅ Read and write permissions
   - ✅ Allow GitHub Actions to create and approve pull requests

### 4️⃣ 验证配置

创建一个测试 PR 来验证配置是否正常工作。

## 📊 Workflow 功能

### 自动触发条件

- PR 创建 (opened)
- PR 更新 (synchronize)
- PR 重新打开 (reopened)
- PR 标记为 ready (ready_for_review)
- 手动触发 (workflow_dispatch)

### 审查内容

- ✅ 代码风格检查
- ✅ 潜在 bug 检测
- ✅ 性能问题分析
- ✅ 安全漏洞扫描
- ✅ 可维护性评估

### 输出结果

1. **PR 评论**：详细的审查报告
2. **Artifacts**：可下载的审查报告 (保留 30 天)
3. **Summary**：GitHub Actions 摘要

## 🔍 自定义配置

### 指定审查的文件类型

编辑 workflow 文件中的 `files` 部分：

```yaml
files: |
  **/*.js
  **/*.ts
  **/*.jsx
  **/*.tsx
  **/*.py
  **/*.go
  **/*.rs
  **/*.java
  **/*.cpp
  **/*.h
  **/*.hpp
```

### 跳过 Draft PR

默认配置已启用，draft PR 不会被审查。

### 自定义审查提示词

修改 workflow 中的 OpenClaw 调用：

```yaml
openclaw run "请审查这个文件的代码质量和潜在问题..."
```

可根据团队需求调整审查重点。

## 📝 示例输出

### PR 评论示例

```markdown
# 代码审查报告

## 变更概览
- PR: #123
- 标题：feat: add user authentication
- 作者：@developer
- 变更文件数：5

## 审查意见

### 文件：`src/auth/login.js`

🔍 发现的问题：
1. 缺少输入验证
2. 错误处理不完善
3. 建议添加单元测试

### 文件：`src/utils/helpers.ts`

✅ 代码质量良好
- 遵循 TypeScript 最佳实践
- 函数命名清晰
- 适当的注释

---
审查完成时间：2026-02-28T04:20:25Z
```

## 🛠️ 故障排查

### Workflow 没有运行

1. 检查 Actions 是否启用
2. 验证 secrets 配置正确
3. 查看 workflow 语法是否正确

### OpenCode API 调用失败

1. 验证 API Key 是否有效
2. 检查网络连接
3. 查看 OpenCode Dashboard 的用量限制

### 权限错误

确保仓库设置中启用了以下权限：
- contents: read
- pull-requests: write
- issues: write

## 📚 相关资源

- [OpenClaw 文档](https://docs.openclaw.ai)
- [GitHub Actions 文档](https://docs.github.com/actions)
- [OpenCode Zen 文档](https://opencode.dev)

## ⚠️ 注意事项

1. **API 用量**：OpenCode Zen 按请求计费，注意查看用量
2. **审查时间**：大型 PR 可能需要较长时间
3. **隐私**：代码会发送到 OpenCode 服务进行处理
4. **限制**：每次 PR 最多审查 50 个文件

---

**最后更新**: 2026-02-28
**版本**: 1.0.0