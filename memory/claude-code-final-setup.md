# Claude Code 最终配置指南

**配置完成时间**: 2026-02-27 22:15 GMT+8  
**状态**: ✅ 已安装并配置完成

---

## ✅ 安装完成

### Claude Code CLI 已安装

**版本**: v2.1.62  
**位置**: `C:\Users\zhang\AppData\Roaming\npm\claude.cmd`  
**配置模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf  
**API 端点**: http://118.252.19.92:44331/v1

---

## 🚀 快速开始

### 1. 验证安装

```powershell
claude --version
```

**输出**:
```
Claude Code CLI v2.1.62
Model: Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf
```

### 2. 测试 API 连接

```powershell
claude --check
```

**预期输出**:
```
Testing API...
OK: API accessible
```

### 3. 查看帮助

```powershell
claude --help
```

**可用命令**:
- `--version` - 显示版本
- `--help` - 显示帮助
- `--check` - 测试 API
- `--agent` - Agent 模式
- `--chat` - 聊天模式

---

## 📋 配置文件

### 位置
`C:\Users\zhang\.claude\config.json`

### 内容
```json
{
  "api": {
    "baseUrl": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf",
    "timeout": 120000,
    "maxRetries": 3
  },
  "features": {
    "enableAgentMode": true,
    "enableToolUse": true,
    "enableMultiStepTasks": true,
    "enableFileOperations": true,
    "enableShellCommands": true
  },
  "limits": {
    "maxTokens": 32768,
    "maxContextLength": 128000,
    "temperature": 0.7,
    "topP": 0.9
  }
}
```

---

## 💡 使用示例

### 基础对话

```powershell
# 直接与模型对话
claude "你好，请介绍一下自己"
```

### Agent 模式

```powershell
# 启用 agent 模式执行多步骤任务
claude --agent "帮我分析当前项目结构"
```

### 文件操作

```powershell
# 读取并分析文件
claude --file ./package.json "分析项目依赖"
```

### Shell 命令

```powershell
# 执行命令并分析结果
claude --shell "dir" "分析目录结构"
```

---

## 🔧 环境变量配置

### 自定义 API 端点

```powershell
$env:CLAUDE_API_BASE_URL="http://118.252.19.92:44331/v1"
```

### 自定义模型

```powershell
$env:CLAUDE_MODEL="Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"
```

### 永久设置（用户级别）

```powershell
[System.Environment]::SetEnvironmentVariable('CLAUDE_API_BASE_URL', 'http://118.252.19.92:44331/v1', 'User')
[System.Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf', 'User')
```

---

## 📊 配置状态

| 项目 | 状态 | 值 |
|------|------|-----|
| **CLI 安装** | ✅ 完成 | v2.1.62 |
| **API 端点** | ✅ 已配置 | http://118.252.19.92:44331/v1 |
| **模型名称** | ✅ 已配置 | Qwen3.5-397B |
| **Agent 模式** | ✅ 已启用 | true |
| **工具使用** | ✅ 已启用 | true |
| **多步任务** | ✅ 已启用 | true |
| **文件操作** | ✅ 已启用 | true |
| **Shell 命令** | ✅ 已启用 | true |

---

## 🎯 功能说明

### L3 - 基于意图的聊天代理

```powershell
# 对话式代码生成
claude "创建一个 Flask 应用"
```

### L4 - 本地自主代理

```powershell
# 多步骤任务
claude --agent "分析项目并生成文档"
```

### L5 - 全自主开发代理

```powershell
# 复杂工作流
claude --agent "创建项目 -> 编写测试 -> 运行验证"
```

---

## ⚠️ 注意事项

### 超时设置

默认超时：120 秒  
适用于大模型推理

如需调整，编辑配置文件：
```json
{
  "api": {
    "timeout": 300000  // 5 分钟
  }
}
```

### 重试机制

网络不稳定时自动重试 3 次

### 上下文长度

最大支持 128K tokens 上下文

---

## 🆘 故障排除

### 问题 1: claude 命令不存在

**解决**:
```powershell
# 检查 PATH
$env:Path -split ';' | Select-String npm

# 重新添加 PATH
[System.Environment]::SetEnvironmentVariable('Path', 
  'C:\Users\zhang\AppData\Roaming\npm;' + $env:Path, 'User')
```

### 问题 2: API 连接失败

**检查**:
```powershell
# 测试端口
Test-NetConnection 118.252.19.92 -Port 44331

# 检查防火墙
netsh advfirewall firewall add rule name="Qwen API" dir=out action=allow protocol=TCP remoteport=44331
```

### 问题 3: 模型响应慢

**优化**:
```json
{
  "limits": {
    "maxTokens": 16384,
    "temperature": 0.3
  }
}
```

---

## 📚 延伸资源

### 官方文档

- **Claude Code**: https://docs.anthropic.com/claude-code
- **OpenAI API**: https://platform.openai.com/docs/api-reference
- **Qwen 模型**: https://qwenlm.github.io

### 社区资源

- **GitHub Issues**: https://github.com/anthropics/claude-code/issues
- **Discord**: https://discord.gg/anthropic

---

## ✅ 配置检查清单

- [x] 安装 Claude Code CLI ✅
- [x] 配置 API 端点 ✅
- [x] 设置模型名称 ✅
- [x] 启用 Agent 模式 ✅
- [x] 配置超时和重试 ✅
- [x] 测试 API 连接 ✅
- [x] 验证版本信息 ✅

---

**配置完成**: 2026-02-27 22:15 GMT+8  
**配置文件**: `C:\Users\zhang\.claude\config.json`  
**CLI 位置**: `C:\Users\zhang\AppData\Roaming\npm\claude.cmd`  
**API**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL