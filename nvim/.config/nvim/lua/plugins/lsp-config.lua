return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = has_cmp and cmp_nvim_lsp.default_capabilities()
				or vim.lsp.protocol.make_client_capabilities()

			-- Access the native config table populated by nvim-lspconfig
			local configs = vim.lsp.config

			-- 1. INJECT CAPABILITIES directly into the tables using vim.tbl_deep_extend
			-- (Notice there are no .setup() calls here anymore!)
			configs.lua_ls = vim.tbl_deep_extend("force", configs.lua_ls or {}, {
				capabilities = capabilities,
			})

			configs.java_language_server = vim.tbl_deep_extend("force", configs.java_language_server or {}, {
				capabilities = capabilities,
			})

			configs.jdtls = vim.tbl_deep_extend("force", configs.jdtls or {}, {
				capabilities = capabilities,
			})

			-- 2. ENABLE THE SERVERS natively
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("java_language_server")
			vim.lsp.enable("jdtls")

			-- Native Bash setup via autocommand remains unchanged and perfectly valid
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*sh",
				callback = function()
					vim.lsp.start({
						name = "bash-language-server",
						cmd = { "bash-language-server", "start" },
					})
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
