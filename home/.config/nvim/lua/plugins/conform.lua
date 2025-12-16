return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = '',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  },
}
