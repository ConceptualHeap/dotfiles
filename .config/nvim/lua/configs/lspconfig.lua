require("nvchad.configs.lspconfig").defaults()

-- read :h vim.lsp.config for changing options of lsp servers 

-- Add filetype detection for shaders
vim.filetype.add({
  extension = {
    hlsl = "hlsl",
    glsl = "glsl",
    wgsl = "wgsl",
  },
})

-- Configure Shader Validator LSP
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")


if not configs.shader_validator then
  configs.shader_validator = {
    default_config = {
      cmd = {
        vim.fn.expand("~/.vscode/extensions/antaalt.shader-validator-1.2.1/bin/linux/shader-language-server"),
      },
      filetypes = { "hlsl", "glsl", "wgsl" },
      root_dir = util.root_pattern(".git", "*.hlsl", "*.glsl", "*.wgsl"),
      settings = {},
    },
  }
end

-- Setup the LSP
require("lspconfig").shader_validator.setup({})

local servers = { "html", "cssls", "clangd", "cmake_language_server", "slangd" }
vim.lsp.enable(servers)
