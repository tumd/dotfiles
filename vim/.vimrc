" enter the current millenium
" must be first, because it changes other options as a side effect
set nocompatible

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

" case insensitive search
set ignorecase
set smartcase
set infercase

" the /g flag on :s substitutions by default
set gdefault

" make backspace behave in a sane manner
set backspace=indent,eol,start

" searching
set hlsearch
set incsearch

" use indents of 4 spaces
set shiftwidth=2

" tabs are spaces, not tabs
set expandtab

" an indentation every four columns
set tabstop=2

" let backspace delete indent
set softtabstop=2

" enable auto indentation
set autoindent

" INTERFACE
" =========

" show matching brackets/parenthesis
set showmatch

" disable startup message
set shortmess+=I

" syntax highlighting
syntax on
set synmaxcol=80
filetype plugin indent on

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

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
set listchars+=space:·
set listchars+=eol:¬

" COMMANDS
" ========

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

command! Reload :source $MYVIMRC

set ttyfast                     " faster redraw
set backspace=indent,eol,start

