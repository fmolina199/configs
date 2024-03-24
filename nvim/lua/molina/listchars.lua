print("=> Loading listchars...")
vim.opt.list = true
vim.opt.listchars = {
	eol = '↵',
	tab = '▏┈',
	space = '·',
	trail = '•',
	extends = '›',
	precedes = '‹',
}
