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
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

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
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["d"] = "delete_buffer"
				}
			}
		}
	}
}
local builtin = require('telescope.builtin')
vim.g.mapleader = ";"
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})


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
require("mason").setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
	on_attach = custom_attach,
	settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = true },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
    },
    },
},
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
lspconfig.solidity.setup {
	capabilities = capabilities
}
lspconfig.angularls.setup {
	capabilities = capabilities
}
lspconfig.ts_ls.setup {
	capabilities = capabilities
}
lspconfig.buf_ls.setup {
	capabilities = capabilities
}
require("mason").setup()
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "gN", function() vim.diagnostic.goto_prev() end)

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
vim.keymap.set("n", "<leader><cr>", ":call jukit#send#line()<cr>")
