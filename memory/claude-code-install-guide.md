# Claude Code 安装与配置指南

**配置时间**: 2026-02-27 21:45 GMT+8  
**接入模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL  
**API 端点**: http://118.252.19.92:44331/v1

---

## ✅ 当前状态

您的 Claude Code 配置文件已创建完成！

**配置文件位置**: `C:\Users\zhang\.claude\config.json` ✅

**已配置内容**:
- ✅ API 端点：http://118.252.19.92:44331/v1
- ✅ 模型名称：Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf
- ✅ Agent 模式：已启用
- ✅ 超时设置：120 秒
- ✅ 重试机制：3 次

---

## 📋 安装步骤（如未安装 Claude Code CLI）

### 步骤 1: 安装 Node.js（如未安装）

```powershell
# 检查 Node.js 是否已安装
node --version

# 如果未安装，访问 https://nodejs.org/ 下载安装
# 推荐安装 LTS 版本（20.x 或 22.x）
```

### 步骤 2: 安装 Claude Code CLI

```powershell
# 使用 npm 全局安装
npm install -g @anthropic-ai/claude-code

# 或使用 yarn
yarn global add @anthropic-ai/claude-code
```

### 步骤 3: 验证安装

```powershell
# 检查版本
claude --version

# 显示帮助信息
claude --help
```

---

## 🔧 配置文件详解

### 当前配置 (`C:\Users\zhang\.claude\config.json`)

```json
{
  "api": {
    "baseUrl": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf",
    "timeout": 120000,
    "maxRetries": 3,
    "retryDelay": 1000
  },
  "features": {
    "enableAgentMode": true,
    "enableToolUse": true,
    "enableMultiStepTasks": true,
    "enableFileOperations": true,
    "enableShellCommands": true,
    "enableBrowserAutomation": false
  },
  "limits": {
    "maxTokens": 32768,
    "maxContextLength": 128000,
    "temperature": 0.7,
    "topP": 0.9
  },
  "logging": {
    "level": "info",
    "file": "~/.claude/claude.log"
  }
}
```

### 配置说明

| 配置项 | 值 | 说明 |
|--------|-----|------|
| **api.baseUrl** | http://118.252.19.92:44331/v1 | 您的本地 API 端点 |
| **api.model** | Qwen3.5-397B... | 完整模型文件名 |
| **api.timeout** | 120000ms | 2 分钟超时，适合大模型推理 |
| **features.enableAgentMode** | true | 启用自主代理模式 |
| **features.enableToolUse** | true | 允许使用工具 |
| **features.enableMultiStepTasks** | true | 支持多步骤任务 |
| **limits.maxTokens** | 32768 | 最大输出 token 数 |
| **limits.maxContextLength** | 128000 | 上下文窗口大小 |

---

## 🚀 快速开始使用

### 基础对话

```powershell
# 测试连接
claude "你好，请测试配置是否正确"
```

### Agent 模式任务

```powershell
# 多步骤任务示例
claude --agent "帮我分析当前项目结构"
```

### 文件操作

```powershell
# 读取文件
claude --file ./package.json "分析这个文件的依赖"

# 创建文件
claude --write ./test.txt "这是一个测试文件"
```

### Shell 命令执行

```powershell
# 执行命令并分析输出
claude --shell "dir" "分析这个目录结构"
```

---

## ✅ 验证配置

### 1. 测试 API 连接

```powershell
# 使用 curl 测试 API 端点
curl http://118.252.19.92:44331/v1/models

# 或使用 PowerShell
Invoke-RestMethod -Uri "http://118.252.19.92:44331/v1/models" | ConvertTo-Json
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

### 2. 测试 Claude Code 配置

```powershell
# 检查配置
claude --check-config

# 详细日志模式
claude --verbose "test"
```

### 3. 网络连通性测试

```powershell
# 测试端口连通性
Test-NetConnection 118.252.19.92 -Port 44331

# 或使用 telnet
telnet 118.252.19.92 44331
```

---

## ⚠️ 常见问题排查

### 问题 1: claude 命令不存在

**错误**: `The term 'claude' is not recognized`

**解决**:
```powershell
# 1. 确认已安装 Claude Code CLI
npm list -g @anthropic-ai/claude-code

# 2. 将 npm 全局包目录添加到 PATH
$env:Path += ";C:\Users\zhang\AppData\Roaming\npm"

# 3. 永久添加（管理员 PowerShell）
[Environment]::SetEnvironmentVariable("Path", $env:Path, "User")
```

### 问题 2: 连接超时

**错误**: `Connection timeout`

**解决**:
```json
// 编辑 config.json，增加超时时间
{
  "api": {
    "timeout": 300000  // 5 分钟
  }
}
```

### 问题 3: 模型不识别

**错误**: `Model not found`

**检查**:
1. 确认 API 端点可访问：`curl http://118.252.19.92:44331/v1/models`
2. 检查模型名称是否完全匹配
3. 验证是否需要 API Key 认证

### 问题 4: 配置文件权限

**错误**: `Permission denied`

**解决**:
```powershell
# 以管理员身份运行 PowerShell
# 或使用以下命令获取文件所有权
takeown /f C:\Users\zhang\.claude\config.json
icacls C:\Users\zhang\.claude\config.json /grant zhang:F
```

---

## 🔒 安全配置

### API 认证（如果需要）

如果您的 API 端点需要认证，编辑 config.json:

```json
{
  "api": {
    "apiKey": "your-api-key-here",
    "headers": {
      "Authorization": "Bearer your-api-key",
      "X-Custom-Header": "value"
    }
  }
}
```

### 防火墙配置

```powershell
# 允许出站连接到 API 端点
netsh advfirewall firewall add rule name="Claude Code API" dir=out action=allow protocol=TCP remoteport=44331
```

---

## 📊 性能优化建议

### 推荐配置

```json
{
  "limits": {
    "maxTokens": 32768,
    "maxContextLength": 128000,
    "temperature": 0.7,
    "topP": 0.9,
    "frequencyPenalty": 0.5,
    "presencePenalty": 0.5
  },
  "cache": {
    "enabled": true,
    "ttl": 3600
  },
  "batching": {
    "enabled": true,
    "maxSize": 10,
    "delayMs": 100
  }
}
```

### 上下文管理

- **短任务**: 使用 `--context-limit 8192`
- **长文档**: 使用 `--context-limit 32768`
- **项目分析**: 使用 `--context-limit 128000`

---

## 🎯 使用场景示例

### 场景 1: 代码重构

```powershell
claude --agent "重构这个项目的错误处理逻辑"
```

### 场景 2: 测试生成

```powershell
claude --agent "为 src/ 目录下的所有文件生成单元测试"
```

### 场景 3: 文档生成

```powershell
claude --agent "根据代码生成 API 文档"
```

### 场景 4: Bug 修复

```powershell
claude --agent "分析并修复测试失败的问题"
```

---

## 📝 配置检查清单

- [x] 创建 `~/.claude/config.json` ✅
- [x] 设置 API 端点 URL ✅
- [x] 设置模型名称 ✅
- [x] 启用 Agent 模式 ✅
- [x] 配置超时和重试 ✅
- [ ] 安装 Claude Code CLI (如未安装)
- [ ] 测试 API 连接
- [ ] 验证模型响应
- [ ] 测试完整工作流

---

## 🆘 故障排除资源

### 日志文件位置

- **Windows**: `C:\Users\zhang\.claude\claude.log`
- **配置路径**: `C:\Users\zhang\.claude\`

### 调试命令

```powershell
# 启用调试模式
$env:CLAUDE_DEBUG="true"

# 查看详细日志
claude --verbose "test command"

# 清除缓存
claude --reset-cache
```

---

## 📚 延伸资源

- **Claude Code 文档**: https://docs.anthropic.com/claude-code
- **OpenAI API 格式**: https://platform.openai.com/docs/api-reference
- **Qwen 模型信息**: https://qwenlm.github.io/

---

**配置状态**: ✅ 配置文件已创建  
**API 端点**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf  
**配置时间**: 2026-02-27 21:45 GMT+8