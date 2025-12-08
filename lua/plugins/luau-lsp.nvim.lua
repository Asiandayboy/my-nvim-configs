return {
	"lopi-py/luau-lsp.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		platform = {
			type = "roblox",
		},
		types = {
			roblox_security_level = "PluginSecurity",
		},
		sourcemap = {
			enabled = true,
			autogenerate = false,
			rojo_path = "rojo",
			rojo_project_file = "default.project.json",
			include_non_scripts = true,
			sourcemap_file = "sourcemap.json",
			generator_cmd = { "rojo", "build", "--output", "sourcemap.json", "--watch" },
		},
		fflags = {
			enable_by_default = false,
			enable_new_solver = true,
			sync = true,
			override = {},
		},
		server = {
			path = "luau-lsp",
		},
	},
}
