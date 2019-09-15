" vim-plug
" Specify a directory for plugins
 call plug#begin('~/.vim/plugged')
   Plug 'dracula/vim', { 'as': 'dracula' }
   Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }
   Plug 'junegunn/vim-easy-align'
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'
 call plug#end()

" air-line
 let g:airline_extensions = []
 let g:airline_theme='dracula'
 let g:airline_powerline_fonts = 1
" air-line simbols
 if !exists('g:airline_symbols')
     let g:airline_symbols = {}
 endif
     " unicode symbols
     let g:airline_left_sep = '»'
     let g:airline_left_sep = '▶'
     let g:airline_right_sep = '«'
     let g:airline_right_sep = '◀'
     let g:airline_symbols.linenr = '␊'
     let g:airline_symbols.linenr = '␤'
     let g:airline_symbols.linenr = '¶'
     let g:airline_symbols.branch = '⎇'
     let g:airline_symbols.paste = 'ρ'
     let g:airline_symbols.paste = 'Þ'
     let g:airline_symbols.paste = '∥'
     let g:airline_symbols.whitespace = 'Ξ'
     " airline symbols
     let g:airline_left_sep = ''
     let g:airline_left_alt_sep = ''
     let g:airline_right_sep = ''
     let g:airline_right_alt_sep = ''
     let g:airline_symbols.branch = ''
     let g:airline_symbols.readonly = ''
     let g:airline_symbols.linenr = ''
"solve insert to normal mode delay
     if ! has('gui_running')
	     set ttimeoutlen=10
	     augroup FastEscape
		     autocmd!
		     au InsertEnter * set timeoutlen=0
		     au InsertLeave * set timeoutlen=1000
	     augroup END
     endif

"theming
"colorscheme overide
 augroup CustomColorScheme
 au!    
 "show only the cursor line
 au ColorScheme * :hi! CursorLine gui=underline term=underline cterm=underline ctermbg=NONE guibg=NONE
 "no background for term transparency
 au ColorScheme * :hi! Normal ctermbg=NONE guibg=NONE
 augroup END

 set cursorline

"line-numbers
 set number

"truecolor
"set Vim-specific sequences for RGB colors
if has("termguicolors")
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " set foreground color
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " set background color
 colorscheme dracula
 set t_Co=256				" Enable 256 colors
 set termguicolors			" Enable GUI colors for the terminal to get truecolor
endif
