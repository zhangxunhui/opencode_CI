# Claude Code Desktop 桌面应用配置指南

**更新时间**: 2026-02-27 22:58 GMT+8

---

## 🖥️ Claude Code Desktop 桌面版

### 官方下载方式

Claude Code 提供以下桌面版本：

## 1. VS Code 扩展（推荐）⭐⭐⭐⭐⭐

**下载**: https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code

**安装步骤**:
1. 打开 VS Code
2. 按 `Ctrl+Shift+X` 打开扩展面板
3. 搜索 "Claude Code"
4. 点击安装
5. 按 `Ctrl+L` 启动

**配置**:
```json
// settings.json
{
  "claudeCode.apiKey": "",
  "claudeCode.apiBase": "http://118.252.19.92:44331/v1",
  "claudeCode.model": "Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"
}
```

---

## 2. JetBrains 插件（IntelliJ IDEA/PyCharm 等）

**下载**: https://plugins.jetbrains.com/plugin/22373-claude-code

**安装步骤**:
1. 打开 JetBrains IDE
2. `File` → `Settings` → `Plugins`
3. 搜索 "Claude Code"
4. 安装并重启 IDE

**配置**:
```
Settings → Tools → Claude Code
API Base URL: http://118.252.19.92:44331/v1
Model: Qwen3.5-397B-A17B-UD-Q4_K_XL
```

---

## 3. Cursor IDE（内置 Claude）⭐⭐⭐⭐

**下载**: https://cursor.sh/

**特点**:
- 原生集成 Claude
- AI-first IDE
- 支持本地模型

**配置**:
```
Settings → AI → Custom API
API Endpoint: http://118.252.19.92:44331/v1
Model: Qwen3.5-397B-A17B-UD-Q4_K_XL
```

---

## 4. Desktop 独立应用（Electron 版）⭐⭐⭐

### 方案 A: 使用开源替代

**推荐项目**: https://github.com/anthropics/claude-desktop

**安装步骤**:

```powershell
# 1. 克隆仓库
git clone https://github.com/anthropics/claude-desktop.git
cd claude-desktop

# 2. 安装依赖
npm install

# 3. 配置环境变量
# 创建 .env 文件
echo "API_BASE_URL=http://118.252.19.92:44331/v1" > .env
echo "MODEL=Qwen3.5-397B-A17B-UD-Q4_K_XL" >> .env

# 4. 启动应用
npm run dev
```

**配置文件位置**: `%APPDATA%\claude-desktop\config.json`

**配置内容**:
```json
{
  "api": {
    "baseUrl": "http://118.252.19.92:44331/v1",
    "model": "Qwen3.5-397B-A17B-UD-Q4_K_XL",
    "timeout": 120000
  },
  "ui": {
    "theme": "dark",
    "fontSize": 14
  }
}
```

---

### 方案 B: 使用 Web 版打包为桌面应用

**工具**: Nativefier（将网页打包为桌面应用）

```powershell
# 1. 安装 nativefier
npm install -g nativefier

# 2. 打包 Web 版
nativefier "http://118.252.19.92:44331" --name "Claude Code Desktop"

# 3. 在生成的目录中运行应用
cd claude-code-desktop-win32-x64
claude-code-desktop.exe
```

---

## 🔧 配置本地 API

### 通用配置步骤

1. **打开设置**
   - VS Code: `File` → `Preferences` → `Settings`
   - JetBrains: `File` → `Settings`
   - Cursor: `Settings` → `AI`

2. **添加自定义 API**
   ```
   API Base URL: http://118.252.19.92:44331/v1
   Model: Qwen3.5-397B-A17B-UD-Q4_K_XL
   API Key: (留空或任意值)
   ```

3. **测试连接**
   ```
   点击 "Test Connection" 或 "Verify"
   应该显示 "Connected" 或 "Success"
   ```

---

## 📊 桌面应用对比

| 应用类型 | 下载 | 难度 | 推荐度 |
|---------|------|------|--------|
| **VS Code 扩展** | ⭐⭐⭐⭐⭐ | 简单 | ⭐⭐⭐⭐⭐ |
| **JetBrains 插件** | ⭐⭐⭐⭐ | 中等 | ⭐⭐⭐⭐ |
| **Cursor IDE** | ⭐⭐⭐⭐⭐ | 简单 | ⭐⭐⭐⭐⭐ |
| **Electron 桌面** | ⭐⭐⭐ | 复杂 | ⭐⭐⭐ |
| **Web 打包版** | ⭐⭐⭐ | 中等 | ⭐⭐⭐ |

---

## 🚀 快速开始（推荐 VS Code 扩展）

### 1. 安装 VS Code（如果未安装）

**下载**: https://code.visualstudio.com/

### 2. 安装 Claude Code 扩展

```
1. 打开 VS Code
2. 左侧扩展图标（或 Ctrl+Shift+X）
3. 搜索 "Claude Code"
4. 点击安装
```

### 3. 配置 API 端点

创建或编辑 `.vscode/settings.json`:

```json
{
  "anthropic-claude.apiBase": "http://118.252.19.92:44331/v1",
  "anthropic-claude.model": "Qwen3.5-397B-A17B-UD-Q4_K_XL",
  "anthropic-claude.timeout": 120000,
  "anthropic-claude.maxTokens": 32768,
  "anthropic-claude.temperature": 0.7,
  "anthropic-claude.topP": 0.9
}
```

### 4. 开始使用

- 按 `Ctrl+L` 打开聊天面板
- 按 `Ctrl+Shift+P` → "Claude Code: New Chat"
- 在代码上右键 → "Claude Code: Explain This"

---

## 🎯 功能特性

### VS Code 扩展功能

- ✅ **聊天模式** - 对话式编码辅助
- ✅ **代码解释** - 选中代码让 AI 解释
- ✅ **代码生成** - 根据描述生成代码
- ✅ **代码审查** - 查找 bug 和优化建议
- ✅ **测试生成** - 自动生成单元测试
- ✅ **重构建议** - 代码优化和重构
- ✅ **文档生成** - 自动生成文档注释

### JetBrains 插件功能

- ✅ **智能对话** - 内嵌聊天窗口
- ✅ **代码补全** - AI 辅助编码
- ✅ **错误修复** - 自动修复建议
- ✅ **代码导航** - 智能代码理解
- ✅ **项目分析** - 整体架构分析

---

## ⚠️ 注意事项

### API 配置

- **API Key**: 如果使用本地 API，可以留空或填任意值
- **Timeout**: 建议设置 120 秒（大模型推理较慢）
- **Max Tokens**: 建议 32768（支持长上下文）

### 网络配置

确保防火墙允许访问：
```
http://118.252.19.92:44331
```

Windows 防火墙命令：
```powershell
netsh advfirewall firewall add rule name="Claude API" dir=out action=allow protocol=TCP remoteport=44331
```

---

## 📝 配置检查清单

### VS Code 扩展

- [x] 安装 VS Code ✅
- [x] 安装 Claude Code 扩展 ✅
- [ ] 配置 API 端点
- [ ] 测试连接
- [ ] 开始使用

### JetBrains 插件

- [x] 安装 JetBrains IDE ✅
- [ ] 安装 Claude Code 插件
- [ ] 配置 API 端点
- [ ] 测试连接

### Electron 桌面应用

- [ ] 克隆仓库
- [ ] 安装依赖
- [ ] 配置 .env
- [ ] 启动应用

---

## 🆘 故障排除

### 问题 1: 扩展无法安装

**解决**:
```
1. 检查 VS Code 版本（建议 1.85+）
2. 手动下载 .vsix 文件安装
3. 重启 VS Code
```

### 问题 2: API 连接失败

**检查**:
```
1. 确认 API 端点正确
2. 检查网络连接
3. 测试端口：Test-NetConnection 118.252.19.92 -Port 44331
```

### 问题 3: 模型响应慢

**优化**:
```json
{
  "anthropic-claude.timeout": 300000,
  "anthropic-claude.maxTokens": 16384,
  "anthropic-claude.temperature": 0.3
}
```

---

## 📚 延伸资源

### 官方文档

- **VS Code 扩展**: https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code
- **JetBrains 插件**: https://plugins.jetbrains.com/plugin/22373-claude-code
- **Cursor IDE**: https://cursor.sh/docs

### 社区资源

- **GitHub Issues**: https://github.com/anthropics/claude-code/issues
- **Discord**: https://discord.gg/anthropic

---

**配置指南**: `memory/claude-code-desktop-guide.md`  
**推荐**: VS Code 扩展（最简单）  
**API**: http://118.252.19.92:44331/v1  
**模型**: Qwen3.5-397B-A17B-UD-Q4_K_XL