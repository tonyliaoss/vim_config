colorscheme shine
set number
syntax on
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre *.cpp : call TrimWhiteSpace()
autocmd BufWritePre *.hpp : call TrimWhiteSpace()

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

