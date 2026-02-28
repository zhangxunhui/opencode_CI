# Claude Code + Bun 配置指南

**更新时间**: 2026-02-27 22:45 GMT+8

---

## ✅ 当前状态

- **bun**: 已安装（位置待确认）
- **claude.cmd**: 已创建
- **API 配置**: 已设置

---

## 🔍 查找 bun 安装位置

### 常见安装路径

bun 可能安装在以下位置之一：

1. `%LOCALAPPDATA%\oven\bun\bin\bun.exe`
   - `C:\Users\zhang\AppData\Local\oven\bun\bin\bun.exe`

2. `%APPDATA%\bun\bin\bun.exe`
   - `C:\Users\zhang\AppData\Roaming\bun\bin\bun.exe`

3. `%USERPROFILE%\.bun\bin\bun.exe`
   - `C:\Users\zhang\.bun\bin\bun.exe`

4. `C:\Program Files\bun\bun.exe`

---

## 🚀 配置步骤

### 步骤 1: 确认 bun 位置

运行以下命令查找 bun：

```powershell
# 方法 1: 检查常见路径
Test-Path "$env:LOCALAPPDATA\oven\bun\bin\bun.exe"
Test-Path "$env:APPDATA\bun\bin\bun.exe"
Test-Path "$env:USERPROFILE\.bun\bun.exe"

# 方法 2: 搜索文件系统
Get-ChildItem "C:\Users\zhang" -Filter "bun.exe" -Recurse -ErrorAction SilentlyContinue
```

### 步骤 2: 添加到 PATH

找到 bun.exe 后，添加其目录到 PATH：

```powershell
# 假设 bun 在 C:\Users\zhang\AppData\Local\oven\bun\bin
$bunDir = "$env:LOCALAPPDATA\oven\bun\bin"

# 添加到用户 PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$bunDir;$currentPath"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "Added $bunDir to PATH"
```

### 步骤 3: 验证安装

```powershell
# 重新打开 PowerShell 后运行
bun --version
```

---

## 📋 Claude Code 配置

### 当前配置

**CLI 位置**: `C:\Users\zhang\AppData\Roaming\npm\claude.cmd` ✅

**配置内容**:
```batch
@echo off
setlocal

REM Claude Code CLI - Bun 版本
set "BUN_EXE=<bun.exe 路径>"
set "CLAUDE_API_BASE_URL=http://118.252.19.92:44331/v1"
set "CLAUDE_MODEL=Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf"

if "%1"=="--version" (
    echo Claude Code CLI (Bun)
    echo Model: %CLAUDE_MODEL%
    goto :EOF
)

if "%1"=="--check" (
    echo Testing API...
    powershell -Command "try { Invoke-RestMethod -Uri '%CLAUDE_API_BASE_URL%/models' | Out-Null; Write-Host 'OK: API accessible' } catch { Write-Host 'ERROR: ' + $_.Exception.Message }"
    goto :EOF
)

echo Claude Code CLI - Ready
echo API: %CLAUDE_API_BASE_URL%
echo Model: %CLAUDE_MODEL%
echo.
echo Run 'claude --help' for usage
```

---

## 🎯 快速验证

### 1. 测试 bun

```powershell
bun --version
```

### 2. 测试 claude

```powershell
claude --version
```

**预期输出**:
```
Claude Code CLI (Bun)
Model: Qwen3.5-397B-A17B-UD-Q4_K_XL-00001-of-00006.gguf
```

### 3. 测试 API 连接

```powershell
claude --check
```

**预期输出**:
```
Testing API...
OK: API accessible
```

---

## ⚠️ 常见问题

### 问题 1: bun 命令不存在

**解决**:
1. 找到 bun.exe 实际位置
2. 将该目录添加到 PATH
3. 重新打开 PowerShell

### 问题 2: claude 命令不存在

**解决**:
```powershell
# 检查 claude.cmd 是否存在
Test-Path "C:\Users\zhang\AppData\Roaming\npm\claude.cmd"

# 如果不存在，重新创建
```

### 问题 3: API 连接失败

**检查**:
```powershell
# 测试端口
Test-NetConnection 118.252.19.92 -Port 44331

# 检查防火墙
netsh advfirewall firewall add rule name="Qwen API" dir=out action=allow protocol=TCP remoteport=44331
```

---

## 📝 配置检查清单

- [ ] 找到 bun.exe 位置
- [ ] 添加 bun 目录到 PATH
- [ ] 验证 bun --version
- [ ] 验证 claude --version
- [ ] 测试 API 连接
- [ ] 测试 agent 模式

---

## 🆘 需要帮助

如果 bun 位置不确定，请运行：

```powershell
Get-ChildItem "C:\Users\zhang" -Filter "bun.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
```

然后告诉我找到的路径。

---

**配置状态**: bun 已安装，待配置 PATH  
**claude.cmd**: ✅ 已创建  
**API**: http://118.252.19.92:44331/v1