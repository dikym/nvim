local sections = {
	lualine_a = {
		{ "mode", right_padding = 0 },
	},
	lualine_b = {
		{
			"filename",
			shorting_target = 80,
			symbols = {
				modified = " ●", -- Text to show when the buffer is modified
				alternate_file = "#", -- Text to show to identify the alternate file
				directory = "", -- Text to show when the buffer is a directory
			},
		},
		"branch",
	},
	lualine_c = {
		{
			"filename",
			path = 3,
			file_status = false,
		},
	},
	lualine_x = { "fileformat" },
	lualine_y = { "filetype", "encoding" },
	lualine_z = {
		{ "location", left_padding = 2 },
	},
}

require("lualine").setup({
	options = {
		theme = "catppuccin",
		component_separators = { left = "->", right = "<-" },
		disabled_filetypes = {
			"NvimTree",
			"Trouble",
		},
	},
	sections = sections,
	inactive_sections = sections,
	tabline = {},
	extensions = {},
})
