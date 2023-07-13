local map = require("core.utils").map
local wk = require("which-key")

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', '<leader>,', '<C-o>',{desc = "<== back"})
-- c-s save
map({'n', 'v'}, '<C-s>','<cmd>w!<cr>')
map('i', '<C-s>','<esc><cmd>w!<cr>a')

-----[[Telescope keymap]]-----
wk.register({
    ["<leader>;"] = { "<cmd> Telescope treesitter<CR>", "treesitter" },
    ["<leader>f"] = {
        name = "find...",
        a = { "<cmd>Telescope live_grep<cr>", "Live grep" },
        b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
        f = { "<cmd>Telescope find_files<cr>", "Find file" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        p = { "<cmd>Telescope projects<cr>", "projects" },
    },
})
-- map a function is ok, amazing
map('n', '<leader>fc', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'Fuzzily search in current buffer' })

-----[[barbar keymap]]-----
-- Goto buffer in position...
map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', {desc = "buffer 1"})
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', {desc = "buffer 2"})
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', {desc = "buffer 3"})
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', {desc = "buffer 4"})
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', {desc = "buffer 5"})
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', {desc = "buffer 6"})
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', {desc = "buffer 7"})
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', {desc = "buffer 8"})
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', {desc = "buffer 9"})
-- Magic buffer picking mode
map('n', '<leader><space>', '<Cmd>BufferPick<CR>', {desc = "magic buffer pick"})
-- Close buffer
-- map('n', '<leader>k', '<Cmd>BufferClose<CR>', {desc = "Close Buffer"})
wk.register({
    ["<leader>b"] = {
        name = "buffer...",
        a = {"<Cmd>BufferCloseAllButCurrent<CR>", "BufferCloseAllButCurrent"},
        c = {"<Cmd>BufferClose<CR>", "Close Current"},
        l = {"<Cmd>BufferCloseLeft<CR>", "BufferCloseLeft"},
        r = {"<Cmd>BufferCloseRight<CR>", "BufferCloseRight"},
    },
})


-----[[barbar keymap]]-----
map('n', '<A-f>', '<Cmd>HopChar1<CR>', {desc = "HopChar1"})
wk.register({
    ["<leader>j"] = {
        name = "jump",
        c = { "<cmd>HopChar1<cr>", "jump to char" },
        l = { "<cmd>HopLine<cr>", "jump to line" },
        w = { "<cmd>HopWord<cr>", "jump to word" },
    },
})
map('n', '<leader>j', '<Cmd>HopChar1<CR>', {desc = "jump"})

-----[[Toggle something]]-----
wk.register({
    ["<leader>t"] = {
        name = "Toggle",
        s = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" },
    },
})

