# AnyPS5 Release 二进制脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/boykopovar/AnyPS5#usage
# 更新日期：2026-10-27
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o anyps5.zip https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/prx-windows-v0.1.3.zip
$h = (Get-FileHash -Algorithm SHA256 anyps5.zip).Hash.ToLower() ; if ($h -ne 'a0d6ce41859368f7be43bb7ceefda8542f9abaaa80f16d157a1847287d46d0e0') { throw "SHA256 校验失败，文件可能不完整，请重试" }
curl.exe -L --fail -o relinker.exe https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/relinker-v0.1.3.exe
$rh = (Get-FileHash -Algorithm SHA256 relinker.exe).Hash.ToLower() ; if ($rh -ne 'c0de554bd426c35d3a38b67720879a0ec8dbdb06d89b0360442e45c7c268d021') { throw "relinker SHA256 校验失败" }
$prxDir = Join-Path $env:USERPROFILE '.local\share\anyps5\prx' ; New-Item -ItemType Directory -Force -Path $prxDir | Out-Null ; Expand-Archive -Path anyps5.zip -DestinationPath $prxDir -Force ; $binDir = Join-Path $env:USERPROFILE '.local\bin' ; New-Item -ItemType Directory -Force -Path $binDir | Out-Null ; Move-Item -Force relinker.exe (Join-Path $binDir 'anyps5-relinker.exe') ; Write-Host "部署完成：prx 库在 $prxDir，relinker 在 $(Join-Path $binDir 'anyps5-relinker.exe')"

Write-Host ''

Write-Host '部署完成：relinker 在 ~/.local/bin/anyps5-relinker，prx 库在 ~/.local/share/anyps5/prx；运行 anyps5-relinker --help 查看用法'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/boykopovar/AnyPS5#usage'
