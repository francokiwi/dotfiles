-- Vim options
vim.g.mapleader = ";"
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.mouse = ''
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8


-- Vim keymaps
vim.keymap.set('n', '<Up>', '')
vim.keymap.set('n', '<Right>', '')
vim.keymap.set('n', '<Left>', '')
vim.keymap.set('n', '<Down>', '')

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Setup lazy
require("config.lazy")

-- Setup colorscheme
require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		lightspeed = true,
		which_key = true
	}
})
vim.g.lightline = {colorscheme = "catppuccin"}
vim.cmd.colorscheme "catppuccin"

-- Vim options
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.mouse = ''
vim.o.relativenumber = true
vim.o.scrolloff = 8

-- Config Telescope
require("telescope").setup{
	defaults = {
		initial_mode = "normal"
	}
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'f', builtin.find_files, {})
vim.keymap.set('n', 'b', builtin.buffers, {})


-- Config cmp
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
	  	['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
	  	['<C-e>'] = cmp.mapping.abort(),
	  	['<C-s>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "vsnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "async_path" }
	}),
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'async_path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- Setup lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {
	capabilities = capabilities
}
lspconfig.quick_lint_js.setup {
	capabilities = capabilities
}
lspconfig.clangd.setup {
	capabilities = capabilities
}
lspconfig.cssmodules_ls.setup {
	capabilities = capabilities
}
lspconfig.csharp_ls.setup {
	capabilities = capabilities
}
lspconfig.gdscript.setup {
	capabilities = capabilities
}

-- Setup dap
local dap = require('dap')
dap.adapters.godot = {
	type = "server",
	host = "127.0.0.1",
	port = 6006
}
vim.g.mapleader = ";"
vim.keymap.set("n", "<leader>bp", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>bc", function() dap.continue() end)
vim.keymap.set("n", "<leader>bso", function() dap.set_over() end)
vim.keymap.set("n", "<leader>bsi", function() dap.set_into() end)
vim.keymap.set("n", "<leader>br", function() dap.repl.open() end)

-- Setup treesitter
local treesitter = require("nvim-treesitter")

treesitter.setup({
	ensure_installed = "all",
	auto_install = true,
	indent = { enable = true },
	highlight = { enable = true },
})

-- Setup refactoring
local refactoring = require("refactoring")
vim.g.mapleader = ";"
refactoring.setup()
vim.keymap.set("x", "<leader>re", ":Refactor extract <CR>")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file <CR>")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var <CR>")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block <CR>")

-- Other
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
