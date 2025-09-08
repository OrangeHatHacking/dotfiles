return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		-- Snippets
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local autoformat_filetypes = { "lua", "rust", "python", "typescript", "javascript" }

		-- === Diagnostics UI ===
		vim.diagnostic.config({
			virtual_text = { spacing = 2, prefix = "●" },
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			signs = true,
			underline = true,
		})

		-- Borders for hover/signature
		local border_opts = { border = "rounded" }
		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, border_opts)
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)

		-- === Capabilities (cmp integration) ===
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- === Keymaps per buffer ===
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local bufnr = ev.buf
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client then return end

				local opts = { buffer = bufnr, silent = true }

				-- LSP actions
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				-- Autoformat on save for specific filetypes
				if vim.tbl_contains(autoformat_filetypes, vim.bo[bufnr].filetype) then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
						end,
					})
				end
			end,
		})

		-- === Mason Setup ===
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"bashls",
				"pyright",
				"ts_ls",
				"html",
				"cssls",
				"eslint",
				"rust_analyzer",
			},
			handlers = {
				function(server)
					require("lspconfig")[server].setup({
						capabilities = capabilities,
					})
				end,

				-- Lua
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = vim.split(package.path, ";"),
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,

				-- TypeScript / JavaScript
				ts_ls = function()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
					})
				end,

				-- Python (Pyright)
				pyright = function()
					require("lspconfig").pyright.setup({
						capabilities = capabilities,
						settings = {
							python = {
								analysis = {
									autoSearchPaths = true,
									useLibraryCodeForTypes = true,
									typeCheckingMode = "basic",
								},
							},
						},
					})
				end,

				-- Rust
				rust_analyzer = function()
					require("lspconfig").rust_analyzer.setup({
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								cargo = { allFeatures = true },
								checkOnSave = { command = "clippy" },
							},
						},
					})
				end,
			},
		})

		-- === Completion Setup ===
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			preselect = cmp.PreselectMode.Item,
			completion = { completeopt = "menu,menuone,noinsert" },
			window = { documentation = cmp.config.window.bordered() },
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer",  keyword_length = 3 },
				{ name = "luasnip", keyword_length = 2 },
			},
			snippet = {
				expand = function(args) require("luasnip").lsp_expand(args.body) end,
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, item)
					local menu_icon = {
						nvim_lsp = "[LSP]",
						buffer = "[Buf]",
						path = "[Path]",
						luasnip = "[Snip]",
					}
					item.menu = menu_icon[entry.source.name] or ("[" .. entry.source.name .. "]")
					return item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-d>"] = cmp.mapping.scroll_docs(5),
				["<C-u>"] = cmp.mapping.scroll_docs(-5),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
