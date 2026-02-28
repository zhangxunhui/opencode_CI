# Claude Code 配置指南 - 接入本地大模型

**配置时间**: 2026-02-27 21:30 GMT+8  
**目标模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL  
**API 端点**: http://118.252.19.92:44331/v1

---

## 📋 配置步骤

### 步骤 1: 确认 Claude Code 安装

```bash
# 检查是否已安装 Claude Code
claude --version

# 如果未安装，需要先安装 Claude Code CLI
# 访问：https://claude.ai/download
```

### 步骤 2: 配置 API 端点

Claude Code 支持通过环境变量或配置文件接入自定义 API 端点。

#### 方法 A: 环境变量配置（推荐）

```bash
# Windows PowerShell
$env:CLAUDE_API_BASE_URL="http://118.252.19.92:44331/v1"
$env:CLAUDE_MODEL="Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"

# 永久设置（添加到系统环境变量）
[System.Environment]::SetEnvironmentVariable('CLAUDE_API_BASE_URL', 'http://118.252.19.92:44331/v1', 'User')
[System.Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf', 'User')
```

#### 方法 B: 配置文件方式

创建或编辑 `~/.claude/config.json`:

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
    "enableMultiStepTasks": true
  }
}
```

**配置文件位置**:
- Windows: `C:\Users\zhang\.claude\config.json`
- macOS/Linux: `~/.claude/config.json`

---

## 🔧 详细配置选项

### config.json 完整配置

```json
{
  "api": {
    "baseUrl": "http://118.252.19.92:44331/v1",
    "apiKey": "",  // 如果需要认证，填写 API Key
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

---

## ✅ 验证配置

### 测试连接

```bash
# 测试 API 连接
curl http://118.252.19.92:44331/v1/models

# 测试 Claude Code 配置
claude --check-config

# 简单测试对话
claude "Hello, test configuration"
```

### 预期输出

```json
{
  "object": "list",
  "data": [
    {
      "id": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf",
      "object": "model",
      "created": 1234567890,
      "owned_by": "qwen"
    }
  ]
}
```

---

## 🚀 使用示例

### 基础对话

```bash
claude "你好，请介绍一下自己"
```

### Agent 模式任务

```bash
# 多步骤任务
claude --agent "帮我创建一个 Python 项目，包含以下功能：
1. 创建一个 Flask 应用
2. 添加 /hello 路由
3. 编写单元测试
4. 运行测试验证"
```

### 文件操作

```bash
# 读取并分析文件
claude --file ./src/main.py "分析这个文件的代码结构"

# 创建新文件
claude --write ./docs/README.md "创建项目文档"
```

### 代码执行

```bash
# 运行命令并分析输出
claude --shell "npm install && npm test" "分析测试失败原因并修复"
```

---

## ⚠️ 常见问题

### 问题 1: 连接超时

**错误**: `Connection timeout`  
**解决**:
```json
{
  "api": {
    "timeout": 300000,  // 增加到 5 分钟
    "maxRetries": 5
  }
}
```

### 问题 2: 模型不识别

**错误**: `Model not found`  
**检查**:
1. 确认 API 端点正确
2. 检查模型名称是否完全匹配
3. 验证 API 认证（如果需要）

### 问题 3: 响应格式错误

**错误**: `Invalid response format`  
**解决**:
```json
{
  "limits": {
    "maxTokens": 16384,  // 降低 token 限制
    "temperature": 0.5   // 降低随机性
  }
}
```

---

## 🔒 安全注意事项

### 1. API 认证

如果 API 端点需要认证，添加 API Key:

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

### 2. 网络访问

确认可以访问目标 IP:

```bash
# Windows PowerShell
Test-NetConnection 118.252.19.92 -Port 44331

# 或使用 telnet
telnet 118.252.19.92 44331
```

### 3. 防火墙配置

确保防火墙允许出站连接:

```bash
# Windows 防火墙允许规则
netsh advfirewall firewall add rule name="Claude Code API" dir=out action=allow protocol=TCP remoteport=44331
```

---

## 📊 性能优化

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
- **长文档**: 使用 `--context-limit 65536`
- **项目分析**: 使用 `--context-limit 128000`

---

## 🎯 最佳实践

### 1. 任务分解

将大任务拆分为小步骤:

```bash
# ❌ 不推荐：一次性完成复杂任务
claude "创建完整的电商网站"

# ✅ 推荐：分步骤执行
claude "1. 创建项目结构"
claude "2. 实现用户认证"
claude "3. 添加商品管理"
```

### 2. 上下文管理

定期清理不必要的上下文:

```bash
claude --reset-context
```

### 3. 错误处理

启用自动重试:

```json
{
  "api": {
    "maxRetries": 3,
    "retryDelay": 1000,
    "retryOn": [429, 500, 502, 503, 504]
  }
}
```

---

## 📝 配置检查清单

- [ ] 安装 Claude Code CLI
- [ ] 配置 `~/.claude/config.json`
- [ ] 设置 API 端点 URL
- [ ] 设置模型名称
- [ ] 测试 API 连接
- [ ] 验证模型响应
- [ ] 配置超时和重试
- [ ] 设置适当的上下文限制
- [ ] 启用必要的功能
- [ ] 配置日志记录
- [ ] 测试完整工作流

---

## 🆘 故障排除

### 日志文件位置

- Windows: `C:\Users\zhang\.claude\claude.log`
- macOS: `~/.claude/claude.log`
- Linux: `~/.claude/claude.log`

### 调试模式

```bash
# 启用详细日志
export CLAUDE_DEBUG=true
claude --verbose "test command"
```

### 常见错误代码

| 错误代码 | 含义 | 解决方案 |
|---------|------|---------|
| 400 | 请求格式错误 | 检查 JSON 配置 |
| 401 | 认证失败 | 添加 API Key |
| 404 | 模型不存在 | 检查模型名称 |
| 429 | 请求限流 | 降低请求频率 |
| 500 | 服务器错误 | 联系 API 提供方 |
| 503 | 服务不可用 | 检查 API 端点状态 |

---

## 📚 延伸资源

- **Claude Code 官方文档**: https://docs.anthropic.com/claude-code
- **OpenAI API 兼容格式**: https://platform.openai.com/docs/api-reference
- **Qwen 模型文档**: https://qwenlm.github.io/

---

**配置完成时间**: 2026-02-27 21:30 GMT+8  
**API 端点**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf