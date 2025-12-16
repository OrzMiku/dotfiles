return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enable = vim.g.have_nerd_font },
  },
  keys = {
    {
      '<leader>fs',
      ':Telescope find_files<cr>',
      mode = { 'n' },
    },
    {
      '<leader>fp',
      ':Telescope git_files<cr>',
      mode = { 'n' },
    },
    {
      '<leader>fz',
      ':Telescope live_grep<cr>',
      mode = { 'n' },
    },
    {
      '<leader>fo',
      ':Telescope oldfiles<cr>',
      mode = { 'n' },
    },
  },
}
