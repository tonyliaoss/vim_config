colorscheme evening
set number
set bg=dark
set tw=79
syntax on
set transparency=15

" adjust tab width here
set shiftwidth=2
set softtabstop=2
set smartindent

" highlights extra white space
highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/

function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction
autocmd BufWritePre *.cpp : call TrimWhiteSpace()
autocmd BufWritePre *.hpp : call TrimWhiteSpace()
autocmd BufWritePre *.c : call TrimWhiteSpace()
autocmd BufWritePre *.h : call TrimWhiteSpace()
autocmd BufWritePre * : call TrimWhiteSpace()

" trims extra whitespace when possible
autocmd BufWinEnter * match ExtraWhiteSpace /\s\+$/
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

