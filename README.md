# opencode_CI

OpenCode 持续集成项目 - 自动化代码审查与质量检查

## 🎯 项目目标

- 自动化代码审查
- 代码质量检查
- CI/CD 流程集成

## 📁 项目结构

```
.
├── .github/
│   └── workflows/
│       └── opencode-review.yml    # OpenCode 代码审查 workflow
├── src/
│   └── ...                         # 源代码
└── README.md
```

## 🚀 配置指南

### 1. 启用 GitHub Actions

1. 点击 **Actions** 标签
2. 点击 **Enable Actions**
3. 添加 Secrets

### 2. 添加 OPENCODE_API_KEY Secret

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. 添加：
   - Name: `OPENCODE_API_KEY`
   - Value: `sk-kUMOUmxNjvTvkZjMPJGcuN6H1CpThRlDxbX0o23wHZX5vtWiywHpwkKGuk9TGxdR`

### 3. 添加 Workflow

在 `.github/workflows/` 目录下创建 `opencode-review.yml`

## 📊 功能特性

- ✅ 自动代码审查
- ✅ PR 评论集成
- ✅ 质量报告生成
- ✅ 可定制审查规则

---

**Powered by OpenClaw + OpenCode Zen**