return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground", -- show treesitter nodes
      "nvim-treesitter/nvim-treesitter-textobjects", -- advanced treesitter objects
      "p00f/nvim-ts-rainbow", -- add rainbow highlighting to parens and brackets
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    additional_vim_regex_highlighting = false,
  },
  {
    "kaiuri/nvim-juliana",
    lazy = false,
    opts = {},
    config = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "towolf/vim-helm" },
  { "neovim/nvim-lspconfig" },
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries",
  },
  { "github/copilot.vim" },
  { "kamwitsta/commentToggle" },
  { "loctvl842/monokai-pro.nvim" },
  { "rebelot/kanagawa.nvim" },
}
