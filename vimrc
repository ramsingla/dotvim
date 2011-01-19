set nocompatible

set number
set ruler
set hidden
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


" My Map Leader
let mapleader = ","

let g:LustyJugglerSuppressRubyWarning = 1 " To suppress the ruby warning.

" Ctags Commmand Required by taglist plugin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let g:easytags_cmd = '/usr/local/bin/ctags'

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Capfile,Vagrantfile,Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Specky
let g:speckyBannerKey        = "<C-S>b"
let g:speckyQuoteSwitcherKey = "<C-S>'"
let g:speckySpecSwitcherKey  = "<C-S>x"
let g:speckyRunSpecKey       = "<C-S>s"
let g:speckyWindowType       = 2
let g:speckyRunSpecCmd       = "rspec -r ~/.vim/ruby/specky_formatter.rb -f SpeckyFormatter" 

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
" Toggles the Taglist View
map <Leader>T :Tlist<CR>
map <Leader>b :LustyJuggler<CR>
map <Leader>B :LustyBufferExplorer<CR>
map <Leader>f :LustyFilesystemExplorer<CR>
map <Leader>F :LustyFilesystemExplorerFromHere<CR>

" Hide the highlighting of the last search term
nnoremap <esc> :noh<return><esc>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
colorscheme railscasts
"colorscheme vividchalk

"Go to previous file
map <Leader>p <C-^> 

"Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" xterm not recognized right by vim
set term=builtin_ansi

" Automatic fold settings for specific files. Uncomment to use.
augroup vimrc
  au BufReadPre *.yml setlocal noexpandtab
  au BufReadPre *.css setlocal foldmethod=indent
  au BufReadPre *.rb,*.js,*.rake setlocal foldmethod=syntax foldlevel=1
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
