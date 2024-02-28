return
{
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<A-p>",       "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
        { "<leader>bP",  "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        { "<A-<>",       "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
        { "<A->>",       "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },

        { "<A-1>",       "<cmd>BufferLineGoToBuffer 1<cr>",         desc = "Next buffer" },
        { "<A-2>",       "<cmd>BufferLineGoToBuffer 2<cr>",         desc = "Next buffer" },
        { "<A-3>",       "<cmd>BufferLineGoToBuffer 3<cr>",         desc = "Next buffer" },
        { "<A-4>",       "<cmd>BufferLineGoToBuffer 4<cr>",         desc = "Next buffer" },
        { "<A-5>",       "<cmd>BufferLineGoToBuffer 5<cr>",         desc = "Next buffer" },
        { "<A-6>",       "<cmd>BufferLineGoToBuffer 6<cr>",         desc = "Next buffer" },
        { "<A-7>",       "<cmd>BufferLineGoToBuffer 7<cr>",         desc = "Next buffer" },
        { "<A-8>",       "<cmd>BufferLineGoToBuffer 8<cr>",         desc = "Next buffer" },
        { "<A-9>",       "<cmd>BufferLineGoToBuffer -1<cr>",        desc = "Next buffer" },

        -- BufferLine Move Next
        { "<leader>bmn", "<Cmd>BufferLineMoveNext<CR>",             desc = "Move Buffer Next" },
        { "<leader>bmp", "<Cmd>BufferLineMovePrev<CR>",             desc = "Move Buffer Prev" },

    },
    opts = {
        options = {
            -- stylua: ignore
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            -- stylua: ignore
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
