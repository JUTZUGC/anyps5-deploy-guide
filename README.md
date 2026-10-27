# AnyPS5 Release 二进制指南

> 第三方部署指南 · 非 AnyPS5 官方仓库。官方项目：[boykopovar/AnyPS5](https://github.com/boykopovar/AnyPS5)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/boykopovar/AnyPS5#usage)为准。

[![⚡ Release 二进制](https://img.shields.io/badge/%E2%9A%A1_Release_%E4%BA%8C%E8%BF%9B%E5%88%B6-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#release二进制推荐用百度搭子)

## Release 二进制（推荐：用百度搭子）

> [!TIP]
> 不想折腾模拟器跑 PS5 游戏，让百度搭子把 AnyPS5 装好，把正版游戏的 ELF 重链接成 exe 直接跑。

⚠️ AnyPS5 当前处于早期开发阶段（v0.1.3），系统库覆盖约 87%，不是所有游戏都能跑。需要用户自备正版 PS5 游戏的可执行文件（ELF/SELF），项目本身不含任何受版权保护的固件或密钥。macOS 目前只有 relinker 二进制可用，没有 prx 库包。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/anyps5-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子按系统下载对应的 prx 库包和 relinker 二进制，核对 SHA256 后解压到用户目录，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## AnyPS5 是什么？

AnyPS5 是开源的48.7k stars，GPL-2.0，把 PS5 可执行文件直接重链接到 Windows/Linux/macOS，不走模拟器（协议：GPL-2.0，<img src="https://img.shields.io/github/stars/boykopovar/AnyPS5?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

一个 PS5 兼容层：提供完整的 PS5 系统 PRX 库实现 + 一个 relinker 工具，把 PS5 的 ELF/SELF 可执行文件重链接成 Windows 或 Linux 原生格式，然后通过 AnyPS5 实现的系统库在 PC 上原生运行，不走模拟器。

- 不走模拟器：直接重链接 PS5 ELF 到 PC 原生格式，没有模拟层开销
- 系统库覆盖约 87%：持续开发中，社区贡献活跃
- Shader 100%：AMD RDNA 1/2 全部 shader 指令已实现
- Web 转换器：boykopovar.github.io/AnyPS5 浏览器端直接转
- SDL 输入：支持手柄（含 Analog）、键盘、鼠标
- 性能覆盖层：F10 切换，实时看 FPS、帧时间、GPU/CPU 占用

（来源：[官方仓库](https://github.com/boykopovar/AnyPS5)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 48.7k stars | 2026-08 建仓，3 个月暴涨，社区 100+ 贡献者 |
| 不走模拟器 | 直接重链接 + 原生执行，没有模拟层开销 |
| 跨平台 | Windows + Linux 有完整包，macOS 有 relinker |
| Shader 100% | RDNA 1/2 全部指令已实现 |
| Web 转换器 | 浏览器里直接转，不下载 |
| GPL-2.0 | 完全开源可二开 |

| 需要注意 | 说明 |
|---|---|
| 早期阶段 | v0.1.3，系统库约 87%，不是所有游戏都能跑 |
| 没有自带游戏 | 需要自己从正版提取可执行文件 |
| macOS 不完整 | 只有 relinker，没有 prx 库包 |
| 首次启动拉引擎 | 大游戏第一次跑会花时间编译 shader |
| 非官方 | 和 Sony 无关，自己担风险 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
if [ "$(uname -s)" = "Darwin" ]; then echo 'macOS 只有 relinker 二进制，没有 prx 库包' ; curl -fL -o relinker https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/relinker-v0.1.3 ; chmod +x relinker ; mkdir -p "$HOME/.local/bin" ; mv relinker "$HOME/.local/bin/anyps5-relinker" ; elif [ "$(uname -s)" = "Linux" ]; then url=https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/prx-linux-v0.1.3.zip ; want=017bdb0e931fa0cdb17f0cea805a824180b88205f5c50f4473550c63a4e811f3 ; curl -fL -o anyps5.zip "$url" ; echo "$want  anyps5.zip" | sha256sum -c - ; mkdir -p "$HOME/.local/share/anyps5/prx" ; unzip -q anyps5.zip -d "$HOME/.local/share/anyps5/prx" ; curl -fL -o relinker https://github.com/boykopovar/AnyPS5/releases/download/v0.1.3/relinker-v0.1.3 ; chmod +x relinker ; mkdir -p "$HOME/.local/bin" ; mv relinker "$HOME/.local/bin/anyps5-relinker" ; else echo '不支持的系统' ; exit 1 ; fi
export PATH="$HOME/.local/bin:$PATH" ; anyps5-relinker --help >/dev/null 2>&1 && echo 'AnyPS5 部署完成' || echo 'relinker 未安装成功，检查 ~/.local/bin/anyps5-relinker'
```

安装包来源：[https://github.com/boykopovar/AnyPS5/releases/tag/v0.1.3](https://github.com/boykopovar/AnyPS5/releases/tag/v0.1.3)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v0.1.3 的 Windows 包 SHA256 a0d6ce41...6d0e0 与 Release 记录一致（92.2 MB） | 已核对 2026-10-27 |
| Release v0.1.3 的 Linux 包 SHA256 017bdb0e...811f3 与 Release 记录一致（97.3 MB） | 已核对 2026-10-27 |
| relinker Windows 二进制 SHA256 c0de554b...8d021 与 Release 记录一致（5.2 MB） | 已核对 2026-10-27 |
| 未实测运行（本机无正版 PS5 游戏的 ELF/SELF 可执行文件） | 说明 2026-10-27 |
| Discord 社区明确禁止使用盗版游戏 | 已核对 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

AnyPS5 没有 MCP server，是纯本地工具。本仓库不提供 MCP 注册。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\anyps5-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

```sh
anyps5-relinker --help          # 查看用法
anyps5-relinker game.elf game.exe   # 把 PS5 可执行文件重链接成 PC 原生格式
```

### 基本流程

1. 从自己的正版游戏里把 PS5 的可执行文件（ELF/SELF）提出来
2. 用 relinker 重链接成目标系统格式
3. 直接运行生成的 exe，AnyPS5 的 prx 库会在背后接管 PS5 系统调用

### Web 转换器

不想下完整包可以用浏览器直接转：[boykopovar.github.io/AnyPS5](https://boykopovar.github.io/AnyPS5)，文件在本地处理不会上传。

### 性能调试

| 操作 | 作用 |
|---|---|
| F10 | 切换性能覆盖层（关闭 → 页面1 → 页面2） |
| `ANYPS5_OVERLAY=1` | 启动时直接显示页面1 |
| `ANYPS5_OVERLAY=2` | 启动时直接显示页面2（详细） |
| `APS5_TRACE_CALLS_FILE=trace.log` | 每 10 秒重写一次已调用的系统函数 |

### 输入配置

默认支持 SDL 兼容的手柄（Xbox / DualSense 等）。自定义键盘鼠标创建 `anyps5-input.ini`，格式见仓库 `docs/user/INPUT_MAPPING.md`。

> ⚠️ 项目明确禁止使用盗版游戏，请自己从合法渠道获取可执行文件。兼容性列表见 GitHub Discussions 的 Game bring-up 板块。

## 常见坑

- relinker 和 prx 版本必须配对，不同版本混用会崩溃
- macOS 目前没有 prx 库包，只能转换不能运行
- 系统库没实现的函数会直接 std::runtime_error 崩溃，看 stderr 报错
- 大游戏 shader 首次编译会卡 F1 很久，正常现象
- 输入默认走 SDL，某些老手柄需要手动映射
- 升级版本记得同时更新 relinker 和 prx 包
- 项目禁止盗版，自己从合法渠道拿可执行文件

## 免责声明

本仓库为第三方指南，与 AnyPS5 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/boykopovar/AnyPS5#usage)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
