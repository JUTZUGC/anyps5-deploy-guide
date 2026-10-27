#!/usr/bin/env bash
set -euo pipefail
# AnyPS5 Release 二进制脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/boykopovar/AnyPS5#usage
# 更新日期：2026-10-27
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

if [ "$(uname -s)" = "Darwin" ]; then echo 'macOS 只有 relinker 二进制，没有 prx 库包' ; curl -fL -o relinker https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/relinker-v0.1.3 ; chmod +x relinker ; mkdir -p "$HOME/.local/bin" ; mv relinker "$HOME/.local/bin/anyps5-relinker" ; elif [ "$(uname -s)" = "Linux" ]; then url=https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/prx-linux-v0.1.3.zip ; want=017bdb0e931fa0cdb17f0cea805a824180b88205f5c50f4473550c63a4e811f3 ; curl -fL -o anyps5.zip "$url" ; echo "$want  anyps5.zip" | sha256sum -c - ; mkdir -p "$HOME/.local/share/anyps5/prx" ; unzip -q anyps5.zip -d "$HOME/.local/share/anyps5/prx" ; curl -fL -o relinker https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/relinker-v0.1.3 ; chmod +x relinker ; mkdir -p "$HOME/.local/bin" ; mv relinker "$HOME/.local/bin/anyps5-relinker" ; else echo '不支持的系统' ; exit 1 ; fi
export PATH="$HOME/.local/bin:$PATH" ; anyps5-relinker --help >/dev/null 2>&1 && echo 'AnyPS5 部署完成' || echo 'relinker 未安装成功，检查 ~/.local/bin/anyps5-relinker'

echo ""

echo "部署完成：relinker 在 ~/.local/bin/anyps5-relinker，prx 库在 ~/.local/share/anyps5/prx；运行 anyps5-relinker --help 查看用法"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/boykopovar/AnyPS5#usage"
