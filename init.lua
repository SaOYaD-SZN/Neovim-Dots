-- Minimum Neovim version check
if vim.fn.has("nvim-0.9") == 0 then
  vim.api.nvim_echo({
    { "Neovim >= 0.9.0 is required for this configuration.\n", "ErrorMsg" },
    { "Please upgrade your Neovim installation.", "WarningMsg" },
  }, true, {})
  return
end

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
