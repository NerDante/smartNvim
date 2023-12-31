-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- relative number 
vim.wo.number = true
vim.wo.relativenumber = true

-- mouse mode
vim.o.mouse = 'nv'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

--Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Encoding
vim.g.termencoding = "utf8"
vim.g.encoding = "utf8"
vim.opt.fileencodings = "utf8,ucs-bom,gbk,cp936,gb2312,gb18030"

-- highlight cursorline
vim.o.cursorline = true

-- disable backup 
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- remain 8 line while scroll 
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- jump to last position while open a file
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
        vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]])
    end
})
