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

-- Check if running on Hyprland or Wayland (via WSL or native Wayland)
if vim.fn.has("unix") == 1 then
  -- Check if /tmp/HYPRLAND exists (indicating Hyprland environment)
  if vim.fn.filereadable("/tmp/HYPRLAND") == 1 then
    -- If running on Hyprland, use copyq for clipboard operations
    if vim.fn.executable("copyq") == 0 then
      print("copyq not found, clipboard integration won't work")
    else
      vim.g.clipboard = {
        name = "copyq (Hyprland)",
        copy = {
          ["+"] = 'copyq copy',
          ["*"] = 'copyq copy'
        },
        paste = {
          ["+"] = (function()
            return vim.fn.systemlist('copyq read --clipboard', {''}, 1)
          end),
          ["*"] = (function()
            return vim.fn.systemlist('copyq read --clipboard', {''}, 1)
          end)
        },
        cache_enabled = true
      }
      print("Clipboard integration: using copyq on Hyprland")
    end
  else
    -- Otherwise, assume a Wayland environment using wl-clipboard (e.g., wl-copy and wl-paste)
    if vim.fn.executable("wl-copy") == 0 then
      print("wl-clipboard not found, clipboard integration won't work")
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
      print("Clipboard integration: using wl-clipboard on Wayland")
    end
  end
end
