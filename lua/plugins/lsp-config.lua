return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
			{
				"folke/which-key.nvim",
				config = function()
					require("which-key").setup({})
				end,
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local wk = require("which-key")

					local keymap_l = {
						name = "[L]SP",
						d = { require("telescope.builtin").lsp_definitions, "Goto Definition" },
						r = { require("telescope.builtin").lsp_references, "Goto References" },
						I = { require("telescope.builtin").lsp_implementations, "Goto Implementation" },
						D = { require("telescope.builtin").lsp_type_definitions, "Type Definition" },
						ds = { require("telescope.builtin").lsp_document_symbols, "Document Symbols" },
						ws = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols" },
						K = { vim.lsp.buf.hover, "Hover Documentation" },
						h = {
							function()
								if vim.lsp.inlay_hint.is_enabled() then
									vim.lsp.inlay_hint.disable()
								else
									vim.lsp.inlay_hint.enable()
								end
							end,
							"Toggle Inlay Hints",
						},
					}

					wk.register(keymap_l, { prefix = "<leader>l", buffer = event.buf })

					wk.register({
						["rn"] = { vim.lsp.buf.rename, "Rename" },
						["ca"] = { vim.lsp.buf.code_action, "Code Action" },
						["gD"] = { vim.lsp.buf.declaration, "Goto Declaration" },
					}, { buffer = event.buf })

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				gopls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
						},
					},
				},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
