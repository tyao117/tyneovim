require'lspconfig'.pyright.setup{
  on_init = function(client)
    client.config.settings.diagnosticMode = "openFilesOnly"
    client.config.settings.useLibraryCodeForTypes = false
    client.config.settings.autoSearchPaths = false
    client.notify("workspace/didChangeConfiguration")
    return true
  end
}
