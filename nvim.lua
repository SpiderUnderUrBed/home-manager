-- Bootstrap lazy.nvim
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--  if vim.v.shell_error ~= 0 then
--    vim.api.nvim_echo({
--      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--      { out, "WarningMsg" },
--      { "\nPress any key to exit..." },
--    }, true, {})
--    vim.fn.getchar()
--    os.exit(1)
--  end
--end
--vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
--require("lazy").setup({
--  spec = {
--    -- add your plugins here
--  },
--  -- Configure any other settings here. See the documentation for more details.
--  -- colorscheme that will be used when installing plugins.
--  install = { colorscheme = { "habamax" } },
--  -- automatically check for plugin updates
--  checker = { enabled = true },
--})

-- Yank current line or selected text to system clipboard with Ctrl+p and log it
vim.keymap.set("n", "<C-p>", function()
  vim.notify("Yanked current line to clipboard", vim.log.levels.INFO)
  vim.cmd('normal! "+yy')  -- Yank the current line in normal mode
end, {})

-- Yank selected text to system clipboard in visual mode
vim.keymap.set("v", "<C-p>", function()
  vim.notify("Yanked selected text to clipboard", vim.log.levels.INFO)
  vim.cmd('normal! "+y')  -- Yank selected text in visual mode
end, {})

-- Yank current line or selected text to system clipboard in insert mode
vim.keymap.set("i", "<C-p>", function()
  vim.notify("Yanked current line or selected text to clipboard in insert mode", vim.log.levels.INFO)
  vim.cmd('normal! "+yy')  -- Yank current line in insert mode
end, {})

-- Yank current line or selected text to system clipboard in visual insert mode
vim.keymap.set("c", "<C-p>", function()
  vim.notify("Yanked selected text to clipboard in visual insert mode", vim.log.levels.INFO)
  vim.cmd('normal! "+y')  -- Yank selected text in visual insert mode
end, {})

vim.notify("Keybind <C-p> set to yank current line to system clipboard", vim.log.levels.INFO)

require("lspconfig").rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            procMacro = {
                enable = true
            },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true
                },
                enableExperimental = true,
            },
            checkOnSave = {
                command = "clippy"
            },
        }
    }
})

-- Check if running on Wayland (via WSL or native Wayland)
if vim.fn.has("unix") == 1 then
  if vim.fn.executable("wl-copy") == 0 then
    vim.notify("wl-clipboard not found, clipboard integration won't work", vim.log.levels.WARN)
  else
    vim.g.clipboard = {
      name = "wl-clipboard (Wayland)",
      copy = {
        ["+"] = 'wl-copy --foreground --type text/plain',
        ["*"] = 'wl-copy --foreground --primary --type text/plain',
      },
      paste = {
        ["+"] = (function()
          return vim.fn.systemlist('wl-paste --no-newline | sed -e "s/\r$//"', {''}, 1)
        end),
        ["*"] = (function()
          return vim.fn.systemlist('wl-paste --primary --no-newline | sed -e "s/\r$//"', {''}, 1)
        end)
      },
      cache_enabled = true
    }
    vim.notify("Clipboard integration: using wl-clipboard on Wayland", vim.log.levels.INFO)
  end
end
