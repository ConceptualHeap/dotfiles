require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "luals", "ts_ls", "tailwindcss", "rust_analyzer", "wgsl_analyzer", "clangd", "cmake-language-server" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
