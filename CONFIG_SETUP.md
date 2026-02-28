# 🚀 OpenCode CI 配置指南

## ✅ 已配置内容

你的仓库已经包含以下配置：

1. ✅ **README.md** - 项目说明文档
2. ✅ **.github/workflows/opencode-review.yml** - OpenCode 代码审查 workflow

## 🔧 配置步骤

### 步骤 1: 初始化仓库并提交

```bash
# 进入仓库目录
cd C:\Users\zhang\.openclaw\workspace\opencode_CI

# 添加所有文件
git add .

# 提交
git commit -m "feat: 初始化 OpenCode CI 配置

- 添加代码审查 workflow
- 配置 OpenCode Zen 集成
- 设置自动化 PR 审查
"

# 推送到 GitHub
git push origin main
```

### 步骤 2: 启用 GitHub Actions

1. 打开仓库页面：https://github.com/zhangxunhui/opencode_CI
2. 点击 **Actions** 标签
3. 如果是首次使用，点击 **Enable Actions**

### 步骤 3: 添加 OPENCODE_API_KEY Secret

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. 填写：
   - **Name**: `OPENCODE_API_KEY`
   - **Value**: `sk-kUMOUmxNjvTvkZjMPJGcuN6H1CpThRlDxbX0o23wHZX5vtWiywHpwkKGuk9TGxdR`
4. 点击 **Add secret**

### 步骤 4: 验证配置

创建一个测试分支并提交 PR：

```bash
# 创建测试分支
git checkout -b test-branch

# 创建测试文件
echo "console.log('Hello, OpenCode!');" > test.js

# 提交
git add test.js
git commit -m "test: 添加测试文件"

# 推送
git push origin test-branch
```

然后在 GitHub 上创建 Pull Request，Actions 会自动运行代码审查。

## 📊 Workflow 功能

### 自动触发

- ✅ PR 创建 (opened)
- ✅ PR 更新 (synchronize)
- ✅ PR 重新打开 (reopened)
- ✅ PR 标记为 Ready (ready_for_review)

### 手动触发

可以在 Actions 标签页手动触发 workflow

### 审查内容

- 📝 代码风格检查
- 🐛 潜在 bug 检测
- ⚡ 性能分析
- 🔒 安全漏洞扫描
- 📖 可维护性评估

## 🔍 查看审查结果

1. **PR 评论**: 详细的审查报告会发布到 PR
2. **Actions 标签**: 查看 workflow 运行详情
3. **Artifacts**: 下载完整的审查报告（保留 30 天）

## ⚠️ 注意事项

1. **API 用量**: OpenCode Zen 按请求计费，请查看用量
2. **审查时间**: 大型 PR 可能需要更长时间
3. **Draft PR**: 默认跳过草稿 PR 的审查

## 🛠️ 故障排查

### Workflow 没有运行

1. 检查 Actions 是否已启用
2. 验证 OPENCODE_API_KEY Secret 是否正确添加
3. 查看 workflow 语法是否正确

### 权限错误

确保仓库设置中：
- Settings → Actions → General
- Workflow permissions: **Read and write**
- ✅ Allow GitHub Actions to create and approve pull requests

### API Key 无效

1. 验证 OPENCODE_API_KEY 是否正确
2. 检查 OpenCode Dashboard 用量限制
3. 重新生成 API Key

## 📚 相关资源

- [OpenClaw 文档](https://docs.openclaw.ai)
- [GitHub Actions 文档](https://docs.github.com/actions)
- [OpenCode Zen](https://opencode.dev)

---

**配置时间**: 2026-02-28  
**版本**: 1.0.0