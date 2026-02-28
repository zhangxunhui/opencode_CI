# 飞书 WebSocket 连接诊断脚本

Write-Host "=== 飞书连接诊断 ===" -ForegroundColor Cyan

# 检查 Gateway 端口
$gatewayPort = 18789
$gatewayListening = netstat -ano | Select-String $gatewayPort
if ($gatewayListening) {
    Write-Host "✓ Gateway 端口 $gatewayPort 正在监听" -ForegroundColor Green
} else {
    Write-Host "✗ Gateway 端口 $gatewayPort 未监听" -ForegroundColor Red
}

# 检查配置文件
$configPath = "C:\Users\zhang\.openclaw\openclaw.json"
if (Test-Path $configPath) {
    Write-Host "✓ 配置文件存在: $configPath" -ForegroundColor Green
    $config = Get-Content $configPath | ConvertFrom-Json
    if ($config.channels.feishu) {
        Write-Host "✓ 飞书配置已启用" -ForegroundColor Green
        Write-Host "  connectionMode: $($config.channels.feishu.connectionMode)" -ForegroundColor Yellow
        Write-Host "  dmPolicy: $($config.channels.feishu.dmPolicy)" -ForegroundColor Yellow
        if ($config.channels.feishu.allowFrom) {
            Write-Host "  allowFrom: $($config.channels.feishu.allowFrom -join ', ')" -ForegroundColor Yellow
        }
    } else {
        Write-Host "✗ 飞书配置未找到" -ForegroundColor Red
    }
} else {
    Write-Host "✗ 配置文件不存在" -ForegroundColor Red
}

# 检查飞书插件
$feishuPluginPath = "C:\Users\zhang\AppData\Roaming\npm\node_modules\openclaw\extensions\feishu"
if (Test-Path $feishuPluginPath) {
    Write-Host "✓ 飞书插件已安装" -ForegroundColor Green
} else {
    Write-Host "✗ 飞书插件未找到" -ForegroundColor Red
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan
Write-Host "提示：如果 WebSocket 连接正常，飞书消息应该能自动推送"
Write-Host "如果收不到消息，请检查飞书开发者后台的事件订阅是否启用了 im.message.receive_v1"