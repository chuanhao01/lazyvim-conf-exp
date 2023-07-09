-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function unmap(mode, lhs)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  keys.active[keys.parse({ lhs, mode = mode }).id] = nil
  pcall(vim.keymap.del, mode, lhs)
end

-- Unmapping Terminal mode configs
unmap("t", "<C-h>") -- Go to left window
unmap("t", "<C-j>") -- Go to lower window
unmap("t", "<C-k>") -- Go to upper window
unmap("t", "<C-l>") -- Go to right window

-- Leader Terminal
map("n", "<leader>t", "<cmd>terminal<cr>", { desc = "Creates a terminal buffer" })
