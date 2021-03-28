" enter the current millenium
" must be first, because it changes other options as a side effect
set nocompatible

" Ensure utf-8
scriptencoding utf-8
set encoding=utf-8

" Load vim-pathogen pluginmgr
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set sessionoptions-=options

" enable syntax and plugins
syntax enable           " enable syntax processing

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

filetype plugin indent on

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
set undodir=~/.vim/undo
set noswapfile

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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
