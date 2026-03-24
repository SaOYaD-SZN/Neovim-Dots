-- lua/utils/init.lua
-- Shared utility functions for Neovim configuration.

---@class Utils
local M = {}

---@class Utils.UI
M.ui = {}

--- Fold expression used when `foldmethod=expr` (Neovim 0.10+).
--- Uses Treesitter when a parser is available for the current buffer,
--- otherwise falls back to no folding (level 0).
---@return string
function M.ui.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- Avoid running on scratch / unnamed buffers
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    local ok = pcall(vim.treesitter.get_parser, buf)
    vim.b[buf].ts_folds = ok
  end
  if vim.b[buf].ts_folds then
    return vim.treesitter.foldexpr()
  end
  return "0"
end

--- Legacy fold text renderer for Neovim < 0.10.
--- Returns a concise summary line for folded regions.
---@return string
function M.ui.foldtext()
  local foldstart = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)[1] or ""
  local line_count = vim.v.foldend - foldstart + 1
  return string.format("▶ %s  [%d lines]", vim.trim(line), line_count)
end

return M
