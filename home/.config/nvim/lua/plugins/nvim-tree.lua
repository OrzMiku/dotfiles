return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enable = vim.g.have_nerd_font },
  },
  opts = {},
  keys = {
    {
      '<leader>e',
      ':NvimTreeFindFileToggle<cr>',
      mode = '',
    },
  },
}
