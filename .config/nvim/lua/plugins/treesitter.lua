return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- auto update parsers
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "markdown",
      "json",
      "javascript",
      "html",
      "css",
      "php",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
