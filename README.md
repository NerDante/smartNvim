# Neovim IDE Config

这是一个基于 `lazy.nvim` 的 Neovim IDE 风格配置，面向 `C/C++`、`Python` 和 `Lua` 开发场景。

当前配置特点：

- 插件管理使用 `lazy.nvim`
- 默认主题为 `tokyonight` 深色
- 支持 `LSP`、补全、诊断、格式化、异步 lint
- 支持 `Telescope` 浮动窗口模糊查询文件、符号、tag、命令
- 支持 `session` 管理
- 支持 `which-key` 按键提示
- 支持启动页、诊断面板、符号大纲、Git 变更查看
- 支持 buffer tabline、快速跳转、多词高亮和增强 textobject/pair 编辑

## 基本说明

- `Leader Key`：`;`
- 配置入口：[init.lua](/home/dante/.config/nvim/init.lua:1)
- 插件目录：[lua/plugins](/home/dante/.config/nvim/lua/plugins)
- 配置目录：[lua/config](/home/dante/.config/nvim/lua/config)

## 目录结构

```text
~/.config/nvim
├── init.lua
├── lazy-lock.json
├── README.md
└── lua
    ├── config
    │   ├── autocmds.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   ├── lsp.lua
    │   ├── options.lua
    │   └── theme.lua
    └── plugins
        ├── colors.lua
        ├── devtools.lua
        ├── editor.lua
        ├── lsp.lua
        ├── session.lua
        ├── telescope.lua
        ├── treesitter.lua
        └── ui.lua
```

## 插件清单

### 1. 插件管理

| 插件 | 作用 |
| --- | --- |
| `folke/lazy.nvim` | 插件管理器，负责插件安装、懒加载、更新与锁版本 |

### 2. 主题与外观

| 插件 | 作用 |
| --- | --- |
| `ellisonleao/gruvbox.nvim` | 可切换的深色主题，适合高对比编码 |
| `folke/tokyonight.nvim` | 默认主题，深色、清晰、适合长时间编码 |
| `navarasu/onedark.nvim` | 可切换的深色主题 |
| `catppuccin/nvim` | 可切换的主题，当前配置为 `mocha` |
| `rebelot/kanagawa.nvim` | 可切换的日式配色主题，当前配置为 `wave` |
| `nvim-tree/nvim-web-devicons` | 为文件、目录、诊断等提供图标 |
| `nvim-lualine/lualine.nvim` | 状态栏 |
| `akinsho/bufferline.nvim` | 顶部 buffer/tabline，显示已打开 buffer，支持诊断标记、顺序调整、快速选择 |

### 3. 模糊搜索与导航

| 插件 | 作用 |
| --- | --- |
| `nvim-telescope/telescope.nvim` | 文件、内容、命令、符号、tag、buffer 的模糊搜索 |
| `nvim-lua/plenary.nvim` | Telescope 等插件的基础依赖库 |
| `nvim-telescope/telescope-fzf-native.nvim` | Telescope 原生 FZF 排序加速，提升搜索体验 |
| `folke/flash.nvim` | 屏幕内快速跳转，支持普通跳转、Treesitter 跳转、增强搜索 |

### 4. LSP、补全与代码智能

| 插件 | 作用 |
| --- | --- |
| `williamboman/mason.nvim` | 统一管理 LSP/工具安装 |
| `williamboman/mason-lspconfig.nvim` | Mason 与 LSPConfig 的桥接 |
| `neovim/nvim-lspconfig` | 配置和启动 LSP 客户端 |
| `hrsh7th/nvim-cmp` | 自动补全主框架 |
| `hrsh7th/cmp-nvim-lsp` | LSP 补全源 |
| `hrsh7th/cmp-buffer` | Buffer 补全源 |
| `L3MON4D3/LuaSnip` | 代码片段引擎 |
| `saadparwaiz1/cmp_luasnip` | 将 LuaSnip 接入补全系统 |
| `rafamadriz/friendly-snippets` | 常用 snippets 集合 |
| `j-hui/fidget.nvim` | LSP 进度提示 |

当前启用的 LSP：

- `clangd`
- `pyright`
- `lua_ls`

其中 `clangd` 已附加：

- 后台索引
- `clang-tidy` 支持
- 头文件自动插入
- 函数参数占位
- 头文件与源文件切换命令

### 5. 代码结构、语法与编辑增强

| 插件 | 作用 |
| --- | --- |
| `nvim-treesitter/nvim-treesitter` | 更准确的语法高亮、缩进、结构分析 |
| `numToStr/Comment.nvim` | 注释切换 |
| `windwp/nvim-autopairs` | 自动补全括号、引号等成对字符，与补全联动 |
| `echasnovski/mini.ai` | 增强 `a` / `i` textobject，改善引号、括号、函数参数、函数调用等 pair 类对象编辑 |
| `Mr-LLLLL/interestingwords.nvim` | 多个词/变量/函数高亮，支持不同颜色同时标记并导航 |
| `lewis6991/gitsigns.nvim` | Git hunk 标记、预览和 blame |

### 6. 格式化与 lint

| 插件 | 作用 |
| --- | --- |
| `stevearc/conform.nvim` | 统一格式化入口，支持手动格式化 |
| `mfussenegger/nvim-lint` | 异步 lint，使用外部工具反馈诊断 |

当前已配置的格式化：

- `C/C++/CUDA`：`clang-format`
- `CMake`：`cmake-format`
- `Python`：`isort` + `black`

当前已配置的 lint：

- `C/C++`：`clang-tidy` + `cppcheck`
- `Python`：`ruff`
- `CMake`：`cmakelint`

### 7. 会话、启动页与辅助界面

| 插件 | 作用 |
| --- | --- |
| `folke/persistence.nvim` | 自动保存/恢复 session |
| `goolord/alpha-nvim` | Lua 启动页，显示最近文件、当前目录入口和常用命令 |
| `folke/which-key.nvim` | Leader 键按键提示 |
| `folke/trouble.nvim` | 诊断、LSP 结果、quickfix/location list 面板 |
| `simrat39/symbols-outline.nvim` | 当前文件符号大纲 |

## 外部依赖

这套配置依赖 Neovim 插件之外的一些命令行工具。未安装时，相关能力会部分失效。

### 安装策略

推荐按下面的方式安装外部工具：

- 系统级工具用系统包管理器安装：
  - `neovim`
  - `git`
  - `make`
  - `clangd`
  - `clang-format`
  - `clang-tidy`
  - `cppcheck`
  - `npm`
- Python 命令行工具优先用 `pipx` 安装：
  - `black`
  - `isort`
  - `ruff`
  - `cmakelang`
- `cmakelang` 会同时提供：
  - `cmake-format`
  - `cmake-lint`
- `pyright` 推荐用 `npm` 全局安装，或交给 `:Mason` 管理

### 必需

| 工具 | 用途 |
| --- | --- |
| `git` | 拉取插件 |
| `nvim >= 0.10` | 运行配置 |

### 推荐

| 工具 | 用途 |
| --- | --- |
| `make` | 编译 `telescope-fzf-native.nvim` |
| `clangd` | C/C++ LSP |
| `clang-format` | C/C++ 格式化 |
| `clang-tidy` | C/C++ 诊断 |
| `cppcheck` | C/C++ 静态检查 |
| `pyright` | Python LSP |
| `black` | Python 格式化 |
| `isort` | Python import 排序 |
| `ruff` | Python lint |
| `cmake-format` | CMake 格式化 |
| `cmakelint` | CMake lint |

### 推荐安装方式

#### 方式 1：优先使用 Mason 安装 LSP

当前配置已经集成：

- `mason.nvim`
- `mason-lspconfig.nvim`

因此以下 LSP 可以直接在 Neovim 中通过 `:Mason` 安装：

- `clangd`
- `pyright`
- `lua_ls`

适合场景：

- 只关心编辑器内可用
- 不想手动维护 LSP 二进制

不适合场景：

- 你希望在终端里也直接使用这些命令
- 你要给 CI、脚本、其他编辑器复用同一套工具链

#### 方式 2：系统包管理器 + pipx + npm

适合场景：

- 希望终端和 Neovim 共享同一套工具
- 希望在项目脚本、CI 中也可直接调用
- 希望自己控制版本

### Ubuntu / Debian

先安装系统级工具：

```bash
sudo apt update
sudo apt install -y \
  neovim git make npm pipx \
  clangd clang-format clang-tidy cppcheck
pipx ensurepath
```

再安装 Python 工具：

```bash
pipx install black
pipx install isort
pipx install ruff
pipx install cmakelang
```

安装 `pyright`：

```bash
npm install -g pyright
```

说明：

- `cmakelang` 会提供 `cmake-format` 和 `cmake-lint`
- 如果你的发行版软件仓库里的 `clangd` 较旧，可以优先用 `:Mason`，或者自行安装更新的 LLVM 版本

### Arch Linux

先安装系统级工具：

```bash
sudo pacman -Syu
sudo pacman -S --needed \
  neovim git make npm pipx \
  clang cppcheck ruff
pipx ensurepath
```

再安装 Python 工具：

```bash
pipx install black
pipx install isort
pipx install cmakelang
```

安装 `pyright`：

```bash
npm install -g pyright
```

说明：

- Arch 的 `clang` 包通常会一并提供 LLVM/Clang 工具链，实际可用命令可用 `clangd --version`、`clang-format --version`、`clang-tidy --version` 检查
- `ruff` 在 Arch 官方仓库中可直接安装；如果你更想统一管理，也可以改成 `pipx install ruff`

### macOS

先安装 Homebrew 管理的系统级工具：

```bash
brew install neovim git make pipx npm llvm cppcheck
pipx ensurepath
```

再安装 Python 工具：

```bash
pipx install black
pipx install isort
pipx install ruff
pipx install cmakelang
```

安装 `pyright`：

```bash
npm install -g pyright
```

说明：

- `clangd` 官方文档推荐通过 Homebrew 安装 `llvm`
- `clang-format`、`clang-tidy`、`clangd` 可能位于 Homebrew 的 LLVM 目录下；如果命令不可用，请把 LLVM 的 `bin` 目录加入 `PATH`

示例：

```bash
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

如果你是 Intel Mac，可按需改为：

```bash
echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 验证安装

安装完成后，可以用下面的命令确认外部依赖是否已就绪：

```bash
nvim --version
git --version
make --version
clangd --version
clang-format --version
clang-tidy --version
cppcheck --version
pyright --version
black --version
isort --version
ruff --version
cmake-format --version
cmake-lint --version
```

### 推荐最小集

如果你只想先把这份配置跑起来，建议至少安装：

```text
neovim
git
make
clangd
clang-format
cppcheck
pipx
npm
black
isort
ruff
cmakelang
pyright
```

### 依赖缺失时的表现

如果某些工具未安装，当前配置的行为如下：

- `clangd` / `pyright` 未安装：对应语言的 LSP 不可用
- `clang-format` / `black` / `isort` 未安装：格式化功能不可用或回退到 LSP format
- `clang-tidy` / `cppcheck` / `ruff` / `cmake-lint` 未安装：对应 lint 会自动跳过，不再报 `ENOENT`
- `make` 未安装：`telescope-fzf-native.nvim` 不会启用原生加速

### C/C++ 工程建议

- 最好在工程根目录提供 `compile_commands.json`
- 如果使用 `CMake`，建议开启：

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -sf build/compile_commands.json .
```

## 按键映射

以下说明中的 `<leader>` 均表示 `;`。

### 1. 通用

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `<Esc>` | Normal | 清除搜索高亮 |
| `;ww` | Normal | 保存文件 |
| `;q` | Normal | 关闭当前窗口 |
| `;bd` | Normal | 删除当前 buffer |
| `;e` | Normal | 打开启动页 |
| `<S-h>` | Normal | 切换到上一个 buffer |
| `<S-l>` | Normal | 切换到下一个 buffer |

### 2. Bufferline / Buffer 管理

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `<S-h>` | Normal | 上一个 buffer |
| `<S-l>` | Normal | 下一个 buffer |
| `;bp` | Normal | 进入 buffer 选择模式并跳转 |
| `;bc` | Normal | 进入 buffer 选择模式并关闭目标 buffer |
| `;bn` | Normal | 当前 buffer 向右移动 |
| `;bN` | Normal | 当前 buffer 向左移动 |
| `;bo` | Normal | 关闭其他 buffer |
| `;bl` | Normal | 关闭右侧所有 buffer |
| `;bh` | Normal | 关闭左侧所有 buffer |
| `;bP` | Normal | 固定/取消固定当前 buffer |

### 3. 窗口管理

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `<C-h>` | Normal | 切换到左侧窗口 |
| `<C-j>` | Normal | 切换到下方窗口 |
| `<C-k>` | Normal | 切换到上方窗口 |
| `<C-l>` | Normal | 切换到右侧窗口 |
| `;ws` | Normal | 水平分屏 |
| `;wv` | Normal | 垂直分屏 |
| `;wd` | Normal | 关闭当前窗口 |

### 4. 主题

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;tt` | Normal | 打开主题切换器 |

### 5. Telescope 搜索

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;ff` | Normal | 查找文件 |
| `;fg` | Normal | 全局文本搜索 |
| `;fb` | Normal | 查找 buffer |
| `;fr` | Normal | 最近文件 |
| `;fh` | Normal | Help Tags |
| `;fc` | Normal | 命令列表 |
| `;f/` | Normal | 当前 buffer 模糊搜索 |
| `;ft` | Normal | 当前 buffer Treesitter 符号 |
| `;fT` | Normal | 项目 tags |
| `;fp` | Normal | Git 文件列表 |
| `;fs` | Normal | 当前文档 LSP 符号 |
| `;fS` | Normal | 工作区 LSP 符号 |

### 6. Session 管理

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;sl` | Normal | 加载当前目录 session |
| `;sL` | Normal | 加载最近一次 session |
| `;ss` | Normal | 用浮动窗口选择 session，支持 `j/k` 和 `Ctrl-j/Ctrl-k` |
| `;sd` | Normal | 停止当前 session 自动保存 |

### 7. 快速跳转

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `s` | Normal/Visual/Operator-pending | Flash 快速跳转 |
| `S` | Normal/Visual/Operator-pending | Flash Treesitter 跳转 |

### 8. 标记与多词高亮

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;mk` | Normal/Visual | 高亮当前词或选中文本，可同时高亮多个目标 |
| `;mK` | Normal | 清除所有颜色高亮 |
| `;mm` | Normal/Visual | 将当前词或选中文本加入搜索并高亮 |
| `;mM` | Normal | 清除搜索高亮词 |
| `n` | Normal | 在当前高亮词/搜索词的下一个位置跳转 |
| `N` | Normal | 在当前高亮词/搜索词的上一个位置跳转 |

### 9. 诊断与问题面板

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;xx` | Normal | 打开/关闭工程级诊断面板 |
| `;xX` | Normal | 打开/关闭当前 buffer 诊断面板 |
| `;xq` | Normal | 打开/关闭 Quickfix 列表 |
| `;xl` | Normal | 打开/关闭 Location List |

### 10. 代码结构

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;o` | Normal | 打开/关闭 Symbols Outline |

### 11. LSP 通用按键

以下按键仅在 LSP 已附加到当前 buffer 后可用。

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `gd` | Normal | 跳转到定义 |
| `gD` | Normal | 跳转到声明 |
| `gr` | Normal | 查找引用 |
| `gI` | Normal | 跳转到实现 |
| `gt` | Normal | 跳转到类型定义 |
| `K` | Normal | 悬停文档 |
| `;ca` | Normal/Visual | 代码动作 |
| `;cr` | Normal | 重命名符号 |
| `;cf` | Normal | 格式化当前 buffer |
| `;cd` | Normal | 查看当前行诊断 |
| `;cD` | Normal | 查看工作区诊断 |
| `;cs` | Normal | 当前文档符号 |
| `;cS` | Normal | 工作区符号 |
| `;cl` | Normal | 查看 LSP 信息 |
| `;cx` | Normal | 用 Trouble 打开符号视图 |
| `;cX` | Normal | 用 Trouble 打开 LSP 结果视图 |
| `[d` | Normal | 上一个诊断 |
| `]d` | Normal | 下一个诊断 |

### 12. C/C++ 专用

以下按键仅在 `clangd` 附加时可用。

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `;ch` | Normal | 在头文件与源文件之间切换 |
| `;ci` | Normal | 查看 clangd 符号信息 |

### 13. Git

以下按键仅在 Git 仓库内对应 buffer 可用。

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `]h` | Normal | 下一个 hunk |
| `[h` | Normal | 上一个 hunk |
| `;gp` | Normal | 预览 hunk |
| `;gb` | Normal | 查看当前行 blame |

### 14. 插入模式补全

以下按键在补全菜单弹出后最常用。

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `<C-b>` | Insert | 向上滚动补全文档 |
| `<C-f>` | Insert | 向下滚动补全文档 |
| `<C-Space>` | Insert | 手动触发补全 |
| `<CR>` | Insert | 确认当前补全项 |
| `<Tab>` | Insert/Select | 下一个补全项，或展开/跳转 snippet |
| `<S-Tab>` | Insert/Select | 上一个补全项，或反向跳转 snippet |

### 15. Pair / Textobject 增强

`mini.ai` 不增加很多显式快捷键，但会显著增强原生 `a` / `i` 文本对象体验，尤其适合引号、括号、参数和函数调用场景。

常用示例：

| 操作 | 说明 |
| --- | --- |
| `ci"` | 修改双引号内文本 |
| `ca"` | 修改包含双引号在内的整体 |
| `di(` | 删除圆括号内部内容 |
| `da(` | 删除包含圆括号在内的整体 |
| `vi)` | 选择括号内部 |
| `va)` | 选择包含括号的整体 |
| `caf` | 修改函数调用整体 |
| `cia` | 修改参数内部 |
| `g[` | 跳到当前 textobject 左边界 |
| `g]` | 跳到当前 textobject 右边界 |

说明：

- 对 `"`、`'`、`` ` ``、`()`, `[]`, `{}` 等 pair 类对象更稳定
- 对函数调用、参数列表等对象支持更好
- 比原生 textobject 覆盖范围更广

### 16. Telescope 窗口内

| 按键 | 模式 | 说明 |
| --- | --- | --- |
| `<C-j>` | Insert | 选择下一项 |
| `<C-k>` | Insert | 选择上一项 |

## which-key 分组

按下 `;` 后，`which-key` 会显示以下主分组：

| 前缀 | 说明 |
| --- | --- |
| `;b` | Buffer 相关 |
| `;c` | 代码/LSP 相关 |
| `;f` | 搜索与定位 |
| `;m` | 标记与多词高亮 |
| `;s` | Session 管理 |
| `;t` | 主题 |
| `;w` | 窗口管理 |
| `;x` | 诊断与问题面板 |

## 常用工作流

### C/C++

1. 用 `;ff` 打开工程文件
2. 确保工程根目录存在 `compile_commands.json`
3. 用 `gd`、`gr`、`K` 做跳转和查看文档
4. 用 `;ch` 在头文件和源文件之间切换
5. 用 `;cf` 手动格式化
6. 用 `;xx` 查看 `clang-tidy` / `cppcheck` 结果
7. 用 `;o` 或 `;cs` 查看符号结构

### Python

1. 用 `;ff` 或 `;fr` 打开文件
2. `pyright` 提供跳转、补全、重命名
3. 用 `;cf` 手动执行 `isort + black`
4. `ruff` 在写入或离开插入模式后触发

## 说明

- 主题默认是 `tokyonight`
- 配色切换会被持久化，下次启动会恢复上次选择
- `Telescope fzf-native` 仅在系统存在 `make` 时启用
- `Symbols Outline` 和 `Trouble` 用于不同层级的信息查看：
  - `Symbols Outline` 更偏当前文件结构
  - `Trouble` 更偏诊断、引用和 LSP 结果聚合

## 后续可选增强

如果后续继续扩展，比较值得加的有：

- `nvim-dap`：调试 C/C++ / Python
- `cmake-tools.nvim`：CMake 构建、运行、切换 target
- 文件树插件：如 `neo-tree.nvim` 或 `oil.nvim`
- 测试运行插件：如 `neotest`
