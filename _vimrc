source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set clipboard=unnamed

let mapleader = ","

set diffexpr=MyDiff()

function MyDiff()

  let opt = '-a --binary '

  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif

  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif

  let arg1 = v:fname_in

  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif

  let arg2 = v:fname_new

  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif

  let arg3 = v:fname_out

  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif

  if $VIMRUNTIME =~ ' '

    if &sh =~ '\<cmd'

      if empty(&shellxquote)

        let l:shxq_sav = ''

        set shellxquote&

      endif

      let cmd = '"' . $VIMRUNTIME . '\diff"'

    else

      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'

    endif

  else

    let cmd = $VIMRUNTIME . '\diff'

  endif

  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3

  if exists('l:shxq_sav')

    let &shellxquote=l:shxq_sav

  endif

endfunction



set nocompatible              " be iMproved, required



filetype off                  " required



" set the runtime path to include Vundle and initialize

call plug#begin('~/.vim/plugged')



" Make sure you use single quotes



" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

Plug 'junegunn/vim-easy-align'



" On-demand loading

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }



Plug 'scrooloose/nerdcommenter'



Plug 'valloric/youcompleteme'

Plug 'altercation/vim-colors-solarized'



Plug 'elixir-lang/vim-elixir'

Plug 'slashmili/alchemist.vim'

Plug 'larrylv/ycm-elixir'

Plug 'wesq3/vim-windowswap'


" Initialize plugin system

call plug#end()

filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:

"filetype plugin on

"

" Brief help

" :PluginList       - lists configured plugins

" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate

" :PluginSearch foo - searches for foo; append `!` to refresh local cache

" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal

"

" see :h vundle for more details or wiki for FAQ

" Put your non-Plugin stuff after this line

"

"

"
autocmd vimenter * NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax enable

set background=dark

colorscheme solarized

nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
