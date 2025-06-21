return {
  "folke/tokyonight.nvim",
  config = function ()
    vim.o.termguicolors = true;

    vim.cmd('colorscheme tokyonight-night');
  end
}
