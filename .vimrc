" enter the current millenium
" must be first, because it changes other options as a side effect
set nocompatible

" Ensure utf-8
scriptencoding utf-8
set encoding=utf-8

" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Plug 'tinted-theming/base16-vim'
Plug 'tumd/base16-vim', { 'branch': 'patch-1' }
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

Plug 'dense-analysis/ale'

Plug 'google/vim-jsonnet'
Plug 'vim-python/python-syntax'
if has("patch-8.0.1453")
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif
Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'junegunn/vim-plug'


" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

if exists('$BASE16_THEME')
    \ && (!exists('g:colors_name') 
    \ || g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif

let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Don't read mode-settings in files
set modelines=0

" hide buffers, not close them
set hidden

" Disable mouse
set mouse=

" maintain undo history between sessions
set undofile
set undodir^=~/.vim/tmp//
" and swap
set swapfile
set directory^=~/.vim/tmp//
" and backup
set backup
set backupdir^=~/.vim/tmp//

" Display all matching files when we tab complete
set wildmenu
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer
set wildmode=longest,list,full
set wildignorecase
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*   

" treat numbers as decimal
set nrformats=

" case insensitive search
set ignorecase
set smartcase
set infercase

" the /g flag on :s substitutions by default
set gdefault

" searching
set hlsearch
set incsearch

" Tabs % Spaces

set shiftwidth=2  " use indents of 2 spaces
set tabstop=2     " an indentation every 2 columns
set softtabstop=2 " let backspace delete indent
set expandtab     " tabs are spaces, not tabs

set autoindent    " enable auto indentation
set formatoptions-=cro " dont continue with comment after enter in insert or o/O

if v:version > 704
  set nofixendofline " don't autoadd newline at the end of files
endif

" make backspace behave in a sane manner
set backspace=indent,eol,start

" Next/prev row when row end/begin
set whichwrap=<,>,h,l,[,]

" Leader Shortcuts
let mapleader=","       " leader is comma


nmap <leader>l :set list!<CR> " Show invisibles
nmap <leader>w :w!<cr>
nmap <leader>r :retab<cr>

nmap <leader>s :call Preserve("%s/\\s\\+$//e")<CR>   " Strip trailing spaces
nmap <leader>i :call Preserve("normal gg=G")<CR>     " Fix indent

" Toggle paste
set pastetoggle=<F9>

" Indent/deindent with tab/shift+tab in command mode
noremap <S-Tab> <<
noremap <Tab> >>
" Indent/deindent with tab/shift+tab in visual or select mode
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Syntax of these languages is fussy over tabs Vs spaces
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" INTERFACE
" =========

" Always show tab-bar
set showtabline=2


" show matching brackets/parenthesis
set showmatch

" disable startup message
set shortmess+=I

" syntax highlighting
syntax on
set colorcolumn=80
"set synmaxcol=80  " Sometimes messes with syntax.

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

" show command in bottom bar
set showcmd

" no line wrapping
set nowrap

" no folding
set nofoldenable
set foldlevel=99
set foldminlines=99
set foldlevelstart=99

" highlight cursor
set cursorline
"set cursorcolumn

" so invisibles
set nolist
set listchars=
set listchars+=tab:▸\
set listchars+=trail:⣿
set listchars+=extends:»
set listchars+=precedes:«
if v:version > 704
  set listchars+=space:· " Added in vim 7.4.710
endif
set listchars+=eol:¬

" COMMANDS
" ========

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" Reload vimrc
command! Reload :source $MYVIMRC

set ttyfast                     " faster redraw
set backspace=indent,eol,start
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction 

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" PLUGINS
" =======
