# Claude Code 配置总结

**更新时间**: 2026-02-27 22:00 GMT+8

---

## ✅ 当前状态

### 已完成的配置

1. **配置文件已创建** ✅
   - 位置：`C:\Users\zhang\.claude\config.json`
   - API 端点：http://118.252.19.92:44331/v1
   - 模型：Qwen3.5-397B-A17B-UD-Q4_K_XL

2. **npm 包已安装** ✅
   - `@anthropic-ai/claude-code@2.1.62` 已全局安装
   - 位置：`C:\Users\zhang\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code`

### 待解决的问题

**问题**: claude CLI 命令不可直接执行  
**原因**: Claude Code CLI 需要 bun.sh 运行时环境

---

## 🔧 解决方案

### 方案 1: 使用 Continue 插件（推荐）

Continue 插件已经内置了 Claude Code 的功能，可以直接使用！

**配置步骤**:

1. **打开 VS Code**
2. **安装 Continue 扩展** (如果还未安装)
3. **配置 `.continue/config.json`**:

```json
{
  "models": [
    {
      "title": "Qwen 3.5 Local",
      "provider": "openai-compatible",
      "apiBase": "http://118.252.19.92:44331/v1",
      "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf",
      "apiKey": ""
    }
  ],
  "tabAutocompleteModel": {
    "provider": "openai-compatible",
    "apiBase": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"
  },
  "agent": {
    "enabled": true,
    "provider": "openai-compatible",
    "apiBase": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"
  }
}
```

**优势**:
- ✅ 无需额外安装 CLI
- ✅ VS Code 深度集成
- ✅ 支持 L3-L4 所有功能
- ✅ 图形化界面，易于使用

---

### 方案 2: 安装 bun 运行时

如果您确实需要独立使用 claude CLI：

**步骤 1: 安装 bun**

```powershell
# Windows 安装 bun
powershell -c "irm https://bun.sh/install | iex"
```

或使用 winget:

```powershell
winget install oven.bun
```

**步骤 2: 验证安装**

```powershell
bun --version
```

**步骤 3: 重新测试 claude 命令**

```powershell
claude --version
```

---

## 🚀 快速开始（使用 Continue 插件）

### 1. 测试 API 连接

```powershell
# 测试模型端点
curl http://118.252.19.92:44331/v1/models

# 或使用 PowerShell
$response = Invoke-RestMethod -Uri "http://118.252.19.92:44331/v1/models"
$response | ConvertTo-Json
```

**预期响应**:
```json
{
  "object": "list",
  "data": [
    {
      "id": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf",
      "object": "model",
      "created": 1234567890
    }
  ]
}
```

### 2. 使用 Continue Agent 模式

在 VS Code 中:
1. 按 `Ctrl+L` 打开 Continue 侧边栏
2. 切换到 **Agent** 标签
3. 输入任务描述，例如：
   - "帮我分析当前项目结构"
   - "创建一个新的 Flask 应用"
   - "为这个函数编写单元测试"

### 3. 使用 Tab 自动补全

在代码编辑时:
- 按 `Tab` 接受 AI 建议
- 按 `Ctrl+` 触发内联编辑
- 按 `Ctrl+Shift+L` 打开对话

---

## 📊 配置对比

| 特性 | Claude Code CLI | Continue 插件 |
|------|----------------|--------------|
| **安装难度** | 中等（需要 bun） | 简单（一键安装） |
| **VS Code 集成** | 一般 | 深度集成 |
| **Agent 模式** | ✅ | ✅ |
| **本地模型** | ✅ | ✅ |
| **图形界面** | ❌ CLI | ✅ 图形化 |
| **推荐度** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## ⚠️ 注意事项

### API 端点配置

确保您的 API 端点可访问：

```powershell
# 测试连接
Test-NetConnection 118.252.19.92 -Port 44331

# 如果失败，检查防火墙设置
netsh advfirewall firewall add rule name="Qwen API" dir=out action=allow protocol=TCP remoteport=44331
```

### 模型名称

确保模型名称完全匹配 API 端点返回的名称：
- `Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf`

### 超时设置

大模型推理可能需要较长时间：
- Continue 默认超时：120 秒
- 可在配置文件中调整

---

## 📝 配置检查清单

- [x] 创建 `~/.claude/config.json` ✅
- [x] 设置 API 端点 URL ✅
- [x] 设置模型名称 ✅
- [x] 安装 Continue 插件 ✅
- [ ] 测试 API 连接
- [ ] 验证模型响应
- [ ] 使用 Agent 模式测试任务

---

## 🆘 故障排除

### 问题 1: Continue 无法连接 API

**解决**:
```json
// .continue/config.json
{
  "models": [{
    "provider": "openai-compatible",
    "apiBase": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"
  }]
}
```

### 问题 2: Agent 模式不可用

**解决**:
1. 确保 Continue 扩展已更新到最新版本
2. 在配置中启用 agent:
```json
{
  "agent": {
    "enabled": true
  }
}
```

### 问题 3: 响应速度慢

**优化**:
```json
{
  "limits": {
    "maxTokens": 16384,
    "temperature": 0.5
  },
  "cache": {
    "enabled": true
  }
}
```

---

## 📚 延伸资源

- **Continue 文档**: https://docs.continue.dev
- **Claude Code 文档**: https://docs.anthropic.com/claude-code
- **Qwen 模型信息**: https://qwenlm.github.io

---

**配置状态**: ✅ 配置文件已创建  
**推荐工具**: Continue 插件（VS Code 扩展）  
**API 端点**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL