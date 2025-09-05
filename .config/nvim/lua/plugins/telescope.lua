-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  -- telescope core
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope")

      t.setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden", -- include dotfiles
            "--glob",
            "!**/.git/*", -- skip .git directory
            -- uncomment if .env is in .gitignore and still missing:
            -- "--no-ignore",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true, -- needed if .env is gitignored
            follow = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*" }
              -- add "--no-ignore" here too if needed
            end,
          },
        },
        -- you can put ui-select config here or in the other spec via opts merging;
        -- keeping it simple: configure here so there's only one setup call
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      -- keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", function()
        builtin.find_files({ hidden = true, no_ignore = true })
      end, { desc = "find files (hidden, no_ignore)" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
    end,
  },

  -- telescope ui-select as a separate spec: only load the extension
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
}
