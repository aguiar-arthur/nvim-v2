local wk = require("which-key")

wk.register({
	["<leader>R"] = {
		name = "[R]ust",
		a = {
			function()
				vim.cmd.RustLsp("codeAction")
			end,
			"Code [A]ction",
		},
		h = {
			function()
				vim.cmd.RustLsp("hover")
			end,
			"[H]over",
		},
		r = {
			name = "[R]unnables",
			r = {
				function()
					vim.cmd.RustLsp("runnables")
				end,
				"[R]unnables",
			},
			d = {
				function()
					vim.cmd.RustLsp("debuggables")
				end,
				"[D]ebuggables",
			},
			t = {
				function()
					vim.cmd.RustLsp("testables")
				end,
				"[T]estables",
			},
		},
		e = {
			function()
				vim.cmd.RustLsp("expandMacro")
			end,
			"[E]xpand [M]acro",
		},
		m = {
			function()
				vim.cmd.RustLsp("rebuildProcMacros")
			end,
			"[R]ebuild [P]roc [M]acros",
		},
		j = {
			function()
				vim.cmd.RustLsp("joinLines")
			end,
			"[J]oin Lines",
		},
		M = {
			name = "[M]ove Item",
			d = {
				function()
					vim.cmd.RustLsp("moveItem", "down")
				end,
				"Move Item [D]own",
			},
			u = {
				function()
					vim.cmd.RustLsp("moveItem", "up")
				end,
				"Move Item [U]p",
			},
		},
		o = {
			name = "[O]pen",
			d = {
				function()
					vim.cmd.RustLsp("openDocs")
				end,
				"[O]pen [D]ocs",
			},
			c = {
				function()
					vim.cmd.RustLsp("openCargo")
				end,
				"[O]pen [C]argo",
			},
		},
		p = {
			function()
				vim.cmd.RustLsp("parentModule")
			end,
			"[P]arent [M]odule",
		},
		w = {
			function()
				vim.cmd.RustLsp("workspaceSymbol")
			end,
			"[W]orkspace [S]ymbol",
		},
	},
})

-- Additional settings
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = 4 -- Indent by four spaces
vim.bo.tabstop = 4 -- A tab is four spaces
