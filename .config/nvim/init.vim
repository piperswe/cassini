if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-scripts/paredit.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_italic=1
colorscheme gruvbox

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
