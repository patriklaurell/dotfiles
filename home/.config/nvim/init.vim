call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" Colorschemes and syntax tools
Plug 'tomasr/molokai'
Plug 'raimondi/delimitmate'
Plug 'yggdroot/indentline'
Plug 'benekastah/neomake' " consider trying out syntastic instead

" Languages
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'digitaltoad/vim-pug'
Plug 'rust-lang/rust.vim'
Plug 'JuliaEditorSupport/julia-vim'

" Frameworks
Plug 'posva/vim-vue'



call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""
" Set space as leader
let mapleader = "\<Space>"

" Enable line numbering
set number

" Buffer is hidden instead of closed when new buffer is opened
set hidden

" Set indentation without hard tabs 
set expandtab
set shiftwidth=2
set softtabstop=2

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Dont redraw when executing macros
set lazyredraw

" Start scrolling when 8 lines from margin
set scrolloff=8

" Open splits to the right and bottom instead of left and top
set splitright
set splitbelow

" Auto resize Vim splits to active split. For some reason winheight
" needs to be there twice to avoid E36 on startup.
set winwidth=80
set winheight=5
set winminwidth=10
set winminheight=5
set winheight=30

" Workaround to get <C-w>h to work for switching window in tmux.
" See https://github.com/neovim/neovim/issues/2048 for details
if has('nvim')
  nmap <BS> <C-w>h
endif

" Make cursor a block in normal mode and a pipe in insert mode.
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschems and syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai

""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <C-Space> to <Esc> in insert and visual mode.
imap <NUL> <Esc>
vmap <NUL> <Esc>

" Map <C-Space> to save file in normal mode.
nmap <NUL> :w<CR>

" Handel wrapped lines as line breaks when navigating
map j gj
map k gk

" Open cheatsheet with <F6>
map <F6> :vsp ~/.config/nvim/cheatsheet.txt<CR>

" H and L end of and beggining of line iin normal mode
nnoremap H ^
nnoremap L $

" J and K move more 5 lines at a time.
nnoremap J 5j
nnoremap K 5k

" <space-,> redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>, :nohl<CR>

" <Leader>w for saving
nnoremap <Leader>fs :w<CR>

" Copy, paste and cut to system clipboard using <Leader>y, p and d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Set ctrl-d to delete in insert mode
inoremap <C-d> <delete>

" Navigate splits using Ctrl-h,j,k,l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


" Keep visual selection selected after indenting/unindenting
vnoremap < <gv
vnoremap > >gv

" w!! for saving files that require root permissions
cmap w!! %!sudo tee > /dev/null %


""""""""""""""""""""""""""""""""""""""""""""""""""
" Pluggin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
" ~~~~~~~ vim-airline ~~~~~~~
" Enable top status line for vim airline
let g:airline#extensions#tabline#enabled = 1

" ~~~~~~~ vim-expand-region ~~~~~~~
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ~~~~~~~ NERDTree ~~~~~~~
" Toggle NERDTree using <C-n>
map <C-f> :NERDTreeToggle<CR>
" Use <space> to open folder or file
let NERDTreeMapActivateNode='<space>'

" ~~~~~~~ CtrlP ~~~~~~~
" Enable different search modes. Including line which searches
" through files. Press <c-p> the <c-f> to cycle through modes.
" http://superuser.com/questions/390011/fuzzy-find-within-file-in-vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']


