call plug#begin(stdpath('config') . '/plugged')
" Declare the list of plugins.

" CoVim provides remote co-editing support to vim"
Plug 'FredKSchott/CoVim'

Plug 'Rigellute/shades-of-purple.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ck3g/vim-change-hash-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'keith/rspec.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'skwp/vim-spec-finder'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-test/vim-test'
Plug 'neomake/neomake'

Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

Plug 'ryanoasis/vim-devicons' " vim-devicons must be last
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


if (has("termguicolors"))
 set termguicolors
endif

set mouse=n
set number
syntax enable
set clipboard+=unnamedplus

" vim-devicons
set encoding=UTF-8
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1

" Colour schemes
" colorscheme nord
" colorscheme neonwave
colorscheme shades_of_purple


set list listchars=tab:\ \ ,trail:·
let mapleader=","

function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>

" Window Managment"
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Run Tests
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" From Ritchie
nnoremap ,r :!bin/rspec %<cr>

" To summon :Git which shows changed files
nnoremap ,g :Git<cr>

" YADR: copy current filname to clipboard"
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
nnoremap <silent> ,cr :let @* = expand("%")<CR>
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

nmap <silent> // :nohlsearch<CR>

let g:fzf_layout = { 'down': '25%' }

command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:ctrlp_map = ',t'
let g:ctrlp_use_caching = 0
nnoremap <silent> ,t :CtrlP<CR>

nnoremap <silent> ,b :CtrlPBuffer<cr>

map ,ja :CtrlP app/assets<CR>
map ,jm :CtrlP app/models<CR>
map ,jc :CtrlP app/controllers<CR>
map ,jv :CtrlP app/views<CR>
map ,jl :CtrlP lib<CR>
map ,js :CtrlP spec<CR>

let g:EasyMotion_keys='asdfjkoweriop'
nmap ,<ESC> ,,w
nmap ,<S-ESC> ,,b

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" Airline config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = airline#section#create(['branch'])
let g:airline#extensions#tabline#enabled = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Additional Syntastic customisations
let g:syntastic_aggregate_errors = 1
let g:syntastic_ruby_checkers = ['mri']

" Run linting automatically.
autocmd VimEnter * call neomake#configure#automake('nrwi', 500)

"  Show hidden files
let NERDTreeShowHidden=1

let g:neomake_open_list = 5
let g:neomake_ruby_enabled_makers = ['rubocop']

" Custom yaml folding and indent guide
autocmd FileType yaml setlocal foldmethod=indent ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal foldmethod=indent ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'

tnoremap <esc><esc> <c-\><c-n>
