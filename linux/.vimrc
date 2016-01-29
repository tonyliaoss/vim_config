colorscheme elflord
set number
syntax on
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
set tw=79

" for the 'Airline' plugin
execute pathogen#infect()
filetype plugin indent on
set laststatus=2

if has("gui_running")
	try
		colorscheme slate
        catch /^Vim\%((\a\+)\)\=:E185/
		try
        		colorscheme desert
        	catch /^Vim\%((\a\+)\)\=:E185/
        		colorscheme darkblue
		endtry
	endtry
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction
autocmd BufWritePre *.cpp : call TrimWhiteSpace()
autocmd BufWritePre *.hpp : call TrimWhiteSpace()
autocmd BufWritePre *.m : call TrimWhiteSpace()

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

