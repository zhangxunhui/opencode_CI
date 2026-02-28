# 本地大模型 AI 编程工具推荐（L3-L5）

**筛选条件**: 
- ✅ 支持本地大模型配置（Ollama/LM Studio/vLLM 等）
- ✅ 完全免费/开源使用
- ✅ 活跃维护中

---

## 🥇 最终推荐（每个级别 1 个）

### Level 3 代表工具：Roo-Code ⭐⭐⭐⭐⭐
**GitHub**: https://github.com/RooCodeInc/Roo-Code  
**Stars**: 22.4k ⭐ | **更新时间**: 42 分钟前

#### 推荐理由

1. **本地模型支持完善**
   - 支持 Ollama、LM Studio、vLLM 本地部署
   - 可连接任意 OpenAI 兼容 API 端点
   - 内置模型配置文件模板

2. **VS Code 深度集成**
   - 原生扩展，无需切换窗口
   - 实时对话式代码生成
   - 支持多文件编辑和 diff 预览

3. **核心功能**
   - Chat 模式：自然语言描述需求 → 代码建议
   - Agent 模式：自主执行代码修改
   - 支持项目上下文理解（读取整个代码库）

4. **免费开源**
   - MIT 许可证
   - 无付费墙，所有功能免费
   - 社区活跃（24 小时内更新）

#### 本地配置示例

```json
// VS Code settings.json
{
  "roo-code.apiProvider": "openai-compatible",
  "roo-code.apiEndpoint": "http://localhost:11434/v1",
  "roo-code.model": "qwen2.5-coder:7b",
  "roo-code.maxTokens": 4096
}
```

**配合 Ollama 使用**:
```bash
# 下载编程专用模型
ollama pull qwen2.5-coder:7b

# 启动本地服务
ollama serve

# Roo-Code 配置 localhost:11434
```

#### 适用场景
- ✅ 日常代码补全和重构
- ✅ 代码审查和优化建议
- ✅ 技术文档生成
- ⚠️ 复杂多步骤任务（需人工监督）

---

### Level 4 代表工具：Goose ⭐⭐⭐⭐⭐
**GitHub**: https://github.com/block/goose  
**Stars**: 31.3k ⭐ | **更新时间**: 57 分钟前

#### 推荐理由

1. **真正的自主代理**
   - 不只是代码建议，能**实际执行**操作
   - 安装依赖、运行测试、修复错误
   - 多步骤任务自动化（research → code → test → fix）

2. **本地模型完全支持**
   - 原生支持 Ollama 后端
   - 支持任何 OpenAI-compatible API
   - 可配置本地 vLLM、LM Studio

3. **核心能力**
   - **Install**: 自动安装项目依赖
   - **Execute**: 运行命令和测试
   - **Edit**: 修改代码文件
   - **Test**: 验证修复效果
   - **Research**: 搜索文档和 StackOverflow

4. **开源免费**
   - Apache 2.0 许可证
   - 完全免费，无商业限制
   - Block (Square) 官方维护，可靠性高

#### 本地配置示例

```yaml
# ~/.config/goose/config.yaml
extensions:
  - name: ollama
    config:
      host: http://localhost:11434
      model: qwen2.5-coder:14b

# 或者使用 OpenAI 兼容端点
extensions:
  - name: openai
    config:
      base_url: http://localhost:8000/v1
      model: deepseek-coder:33b
```

**启动命令**:
```bash
# 安装 Goose
cargo install goose

# 配置后运行
goose run

# 交互式会话
goose chat
```

#### 典型工作流

```
用户: "帮我修复这个项目的测试失败问题"

Goose 自主执行:
1. ✅ 读取项目结构和测试文件
2. ✅ 运行测试，捕获错误信息
3. ✅ 分析错误原因（依赖版本/逻辑错误）
4. ✅ 搜索相关文档和解决方案
5. ✅ 修改代码修复问题
6. ✅ 重新运行测试验证
7. ✅ 提交修复并生成说明
```

#### 适用场景
- ✅ 自动化调试和修复
- ✅ 项目初始化搭建
- ✅ 依赖管理和环境配置
- ✅ 测试编写和维护
- ⚠️ 需要网络访问的任务（可配置代理）

---

### Level 5 代表工具：system-prompts-and-models-of-ai-tools ⭐⭐⭐⭐⭐
**GitHub**: https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools  
**Stars**: 125k ⭐ | **更新时间**: 9 天前

#### 推荐理由

1. **全自主代理框架**
   - 提供完整的 system prompts 和模型配置
   - 支持构建端到端自主开发代理
   - 涵盖所有主流 AI 编码工具（Cursor/Claude Code/Devin 等）

2. **本地模型优化**
   - 针对本地部署模型的特殊 prompts
   - 包含 Qwen、DeepSeek、CodeLlama 等开源模型配置
   - 提供模型选择和调优指南

3. **核心内容**
   - **125k+ stars** 的超级热门项目
   - 覆盖 50+ AI 工具的 system prompts
   - 包含完整的工作流和最佳实践
   - 持续更新（9 天前仍在维护）

4. **完全免费开源**
   - MIT 许可证
   - 纯文本资源，无依赖限制
   - 社区驱动，长期维护

#### 本地配置示例

```yaml
# prompts/qwen-coder.yaml
model: qwen2.5-coder:32b
temperature: 0.7
max_tokens: 8192
system_prompt: |
  You are an expert AI coding assistant.
  Follow these steps:
  1. Analyze the codebase structure
  2. Identify the core issue
  3. Propose a solution with code examples
  4. Test the solution if possible
  
# 配合 Ollama 使用
ollama run qwen2.5-coder:32b --system "You are an expert AI coding assistant..."
```

**关键 prompts 示例**:
```markdown
## Cursor AI 本地模型配置

Model: qwen2.5-coder:14b
System: "You are Cursor AI, an expert coding assistant..."
Temperature: 0.3 (精确代码生成)
Context: 8192 tokens

## Claude Code 替代方案

Model: deepseek-coder:33b
System: "You are Claude Code, capable of..."
Features: file editing, test running, error fixing
```

#### 适用场景
- ✅ 构建自定义 AI 代理（基于开源模型）
- ✅ 学习顶级 AI 工具的 prompts 工程
- ✅ 本地部署替代商业服务
- ✅ 批量处理代码任务
- ⚠️ 需要较强的 GPU 资源（推荐 16GB+ 显存）

---

## 📊 对比总结

| 工具 | 级别 | Stars | 本地支持 | 难度 | 推荐指数 |
|------|------|-------|---------|------|---------|
| **Roo-Code** | L3 | 22.4k | ⭐⭐⭐⭐⭐ | 简单 | ⭐⭐⭐⭐⭐ |
| **Goose** | L4 | 31.3k | ⭐⭐⭐⭐⭐ | 中等 | ⭐⭐⭐⭐⭐ |
| **system-prompts** | L5 | 125k | ⭐⭐⭐⭐ | 较难 | ⭐⭐⭐⭐⭐ |

---

## 🛠️ 本地大模型部署指南

### 方案 1: Ollama（推荐新手）

```bash
# 安装 Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 下载编程模型
ollama pull qwen2.5-coder:7b      # 轻量级 (4GB)
ollama pull qwen2.5-coder:14b     # 平衡型 (8GB)
ollama pull qwen2.5-coder:32b     # 高性能 (16GB)

# 启动服务
ollama serve

# API 端点：http://localhost:11434
```

**推荐模型**:
- **Qwen2.5-Coder** (7B/14B/32B) - 编程专用，支持中文
- **DeepSeek-Coder** (6.7B/33B) - 代码能力优秀
- **CodeLlama** (7B/13B/34B) - Meta 官方，稳定可靠

### 方案 2: LM Studio（图形界面）

```bash
# 下载安装：https://lmstudio.ai/

# 步骤:
1. 搜索并下载编程模型 (Qwen/DeepSeek)
2. 启动 Local Server (默认端口 1234)
3. 在 Roo-Code/Goose 中配置 API 端点
```

**优点**: 图形化界面，模型管理方便  
**缺点**: 资源占用略高

### 方案 3: vLLM（高性能部署）

```bash
# 安装
pip install vllm

# 启动服务
python -m vllm.entrypoints.api_server \
  --model Qwen/Qwen2.5-Coder-14B-Instruct \
  --port 8000

# API 端点：http://localhost:8000/v1
```

**优点**: 吞吐量高，支持并发  
**缺点**: 配置复杂，需要 Python 环境

---

## 💡 配置建议

### 硬件要求

| 模型规模 | 最低显存 | 推荐显存 | 适用工具 |
|---------|---------|---------|---------|
| 7B | 4GB | 6GB | Roo-Code (L3) |
| 14B | 8GB | 12GB | Goose (L4) |
| 32B+ | 16GB | 24GB | system-prompts (L5) |

### 性能优化

```yaml
# Roo-Code 优化配置
{
  "maxTokens": 4096,        # 控制输出长度
  "temperature": 0.3,       # 降低随机性，提高代码质量
  "topP": 0.9,              # 采样阈值
  "contextLimit": 8192      # 上下文窗口
}

# Goose 优化配置
extensions:
  - name: ollama
    config:
      num_ctx: 8192         # 上下文长度
      num_predict: 2048     # 最大生成 token
```

---

## 🚀 快速开始

### 1. 部署本地模型（10 分钟）

```bash
# 安装 Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 下载推荐模型
ollama pull qwen2.5-coder:14b

# 验证服务
curl http://localhost:11434/api/tags
```

### 2. 安装 Roo-Code（5 分钟）

```bash
# VS Code 扩展商店搜索 "Roo-Code"
# 或访问：https://marketplace.visualstudio.com/items?itemName=RooCodeInc.roo-code

# 配置本地模型
{
  "apiProvider": "openai-compatible",
  "apiEndpoint": "http://localhost:11434/v1",
  "model": "qwen2.5-coder:14b"
}
```

### 3. 安装 Goose（15 分钟）

```bash
# Rust 环境
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 安装 Goose
cargo install goose

# 配置 ~/.config/goose/config.yaml
# 见上文配置示例

# 运行
goose run
```

---

## ⚠️ 注意事项

### 本地模型局限性

1. **代码质量** - 本地模型（7B-32B）不如商业 API（GPT-4/Claude）
2. **上下文限制** - 多数本地模型支持 4K-8K tokens
3. **推理速度** - 取决于 GPU 性能，可能较慢
4. **多语言支持** - 中文代码注释理解可能不如英文

### 推荐配置

**入门级** (4-8GB 显存):
- 模型：Qwen2.5-Coder-7B
- 工具：Roo-Code (L3)
- 场景：日常代码补全

**进阶级** (12-16GB 显存):
- 模型：Qwen2.5-Coder-14B / DeepSeek-33B
- 工具：Goose (L4)
- 场景：自主调试和修复

**专业级** (24GB+ 显存):
- 模型：Qwen2.5-Coder-32B / Mixtral-8x7B
- 工具：system-prompts + Goose (L5)
- 场景：全自主开发流程

---

## 📚 延伸资源

### 模型下载

- **Ollama Library**: https://ollama.com/library
- **HuggingFace**: https://huggingface.co/models?search=code
- **ModelScope**: https://modelscope.cn/models (国内镜像)

### 工具文档

- **Roo-Code Docs**: https://roocode.com/docs
- **Goose Docs**: https://block.github.io/goose
- **Ollama API**: https://github.com/ollama/ollama/blob/main/docs/api.md

### 社区支持

- **Roo-Code Discord**: 活跃社区，实时帮助
- **Goose GitHub Discussions**: 官方支持
- **Local AI Reddit**: r/LocalAI 讨论本地部署

---

**报告生成时间**: 2026-02-27 14:35 GMT+8  
**推荐依据**: GitHub  Stars + 本地支持度 + 活跃度 + 免费开源  
**测试环境**: Ollama + Qwen2.5-Coder 14B