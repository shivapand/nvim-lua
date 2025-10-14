return {
	'kien/ctrlp.vim',
	config = function()
		local vimrc = vim.fn.stdpath('config') .. '/vim/ctrlp.vim'

		vim.cmd.source(vimrc)
	end
}
