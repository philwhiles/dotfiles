
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"let g:deoplete#enable_at_startup = 1


" START FOR STARTIFY
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']}
        \ ]
let g:startify_custom_header = ''
" END FOR STARTIFY

iabbrev teh the

set maxmempattern=5000
" helps with lag when scrolling?
set lazyredraw
" fixes hanging when opeing typescript files
set regexpengine=2

" allow cursor to go beyond physical EOL in block mode (Ctrl-V)
set virtualedit=block
set backspace=indent,eol,start "allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
"set ignorecase    " ignore case when searching
set smartcase     " but, ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to, shiftwidth,not tabstop
set title         " set terminal title
"set list
"tab characters, trailing whitespace and invisible spaces visually, and
"additionally use the # sign at the end of lines to mark lines that extend off-screen
set listchars=trail:.,extends:#,nbsp:.
let g:go_fmt_autosave=0
"set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+.

"silversearcher is sys cmd installed with brew
"let g:ackprg = 'ag --nogroup --nocolor --column'

"ripgrep is sys cmd installed with brew
"set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_space_tab_error = 0

set hidden
set foldcolumn=5
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
filetype indent on
filetype plugin indent on
set foldmethod=syntax

set foldlevelstart=99
set nrformats=hex,alpha
"set path=./**
set path+=**
set mouse=a
set autowrite

set expandtab
set softtabstop=2
set tabstop=2

"let g:Powerline_colorscheme= 'solarized256'

set t_Co=256
set guioptions=gmtrb
set undofile
set history=1000
set incsearch
set laststatus=2
set mousehide
set nocompatible
set nowrap
set ruler
set showcmd
set showmode
set statusline=[%n]\ %20.60t\ (\%M%R%H)\ C%c\ L%l%=%b(%B)\ HEX)

set viminfo='50,<1000,s100,%,\"100,n~/.vim/viminfo
set directory=~/.vim/swaps
set undodir=~/.vim/undo

set visualbell
set wildmenu

"au VimLeave * :!open -a iTerm
au VimLeave * :!open -a terminal

syntax on
let java_highlight_all=1
set background=dark
let mapleader=","
let localmapleader=","

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

" exec the text on current line in sh and replace it with the result
noremap <Leader>x !!bash<cr>

"
" add yaml stuffs
"au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
"autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set encoding=UTF-8

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#whitespace#enabled = 0
function! AirlineInit()
  let g:airline_section_z = airline#section#create_right(['%l %c [%B]'])
endfunction
autocmd VimEnter * call AirlineInit()


" Tab navigation like Firefox.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>

" Copy and paste to/from system clipboard with ease
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" switch buffers easily with shift left and right cursor keys
map <S-Left> :bp<CR>
map <S-Right> :bn<CR>

imap § 

" remap : so that using shift to type :w becomes ;w instead !
" nnoremap ; :

" change behaviour of nav over long wrapped lines so that it jumps to the next row in the editor 
nnoremap j gj
nnoremap k gk

colorscheme philwhiles

set relativenumber
set number
set cursorcolumn
"set cursorline
"add hyphen to word boundary chars for searching etc
set isk+=-
set isk+=_

au BufNewFile, BufRead *.py
      \ set tabstop=2 |
      \ set foldmethod=indent


" GUI and plugin configs from here on
if has("gui_macvim")
  execute pathogen#infect()

  let g:minimap_auto_start = 1
  let g:minimap_auto_width = 100
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
  autocmd VimEnter * call AddCycleGroup(['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'])
  " use the camelCaseMotion defaults 
  call camelcasemotion#CreateMotionMappings('<leader>')
  autocmd VimEnter * call AddCycleGroup('java', ['public', 'private', 'protected'])

  set macligatures
  "GITGUTTER
  let g:gitgutter_enabled = 1
  let g:gitgutter_max_signs = 1000
  set updatetime=100

  " Write file when you forget to use sudo
  cmap w!! w !sudo tee % >/dev/null

  "NERDTREE
  autocmd FileType nerdtree setlocal nocursorcolumn
  autocmd FileType tagbar setlocal nocursorcolumn
  autocmd FileType help setlocal nocursorcolumn
  autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif
  "autocmd FileType go setlocal guifont=GoMono:h13

  let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                     \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
  let NERDTreeShowFiles=1
  let NERDTreeShowBookmarks=0
  " Display arrows instead of ascii art in NERDTree
  let NERDTreeDirArrows=1
  " Change current working directory based on root directory in NERDTree
  let NERDTreeChDirMode=2

  "close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


  let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }
  nmap <silent> <leader>n :NERDTree<CR>
  "I use the following mapping to view the current buffer in NERDTree: 
  map <leader>f :NERDTreeFind <CR> :wincmd p<cr>
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1
  " prevent reload of devicons and odd [ icon ] display
  " after a re-source, fix syntax matching issues (concealing brackets):
  if exists('g:loaded_webdevicons')
      call webdevicons#refresh()
  endif
  let g:webdevicons_enable_airline_tabline = 1
  let g:webdevicons_enable_airline_statusline = 1


  "ULTISNIPPETS
  "set runtimepath+=/Users/philwhiles/.vim
  let g:UltiSnipsUsePythonVersion = 2
  let g:UltiSnipsSnippetsDir=["/Users/philwhiles/.vim"]
  " my own snippets
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  "let g:UltiSnipsExpandTrigger="<C-Tab>"
  let g:UltiSnipsEditSplit="vertical"
  "<C-@> is ctrl space
  let g:UltiSnipsListSnippets="<C-s>"
  
  " better key bindings for UltiSnipsExpandTrigger
  let g:UltiSnipsExpandTrigger="<c-space>"
  let g:UltiSnipsJumpForwardTrigger="<c-l>"
  let g:UltiSnipsJumpBackwardTrigger="<c-h>"

    "YOUCOMPLETEME
    " make YCM compatible with UltiSnips (using supertab)
  let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
  let g:SuperTabDefaultCompletionType = '<C-Tab>'
  "
  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>
  " and bashrc
  nmap <silent> <leader>eb :e ~/.bashrc<CR>
  nmap <silent> <leader>ee :e  /Users/philwhiles/Library/Application\ Support/espanso/match/base.yml<CR>

  " quickly off hls
  nmap <silent> <leader>/ :nohlsearch<CR>


  "DASH
  nmap <silent> <leader>d <Plug>DashSearch  
  "associate dash docsets with file extensions
  let g:dash_map = {
        \ 'python' : 'py',
        \ 'java' : 'java'
        \}

  autocmd FileType java :DashKeywords java11 sospring sojava
  autocmd FileType sh :DashKeywords bash
  autocmd FileType yml :DashKeywords docker kubernetes sodocker
  autocmd FileType py :DashKeywords python3 python2 sopython

  set guifont=GoMonoNerdFontCompleteM-:h12
  "set guifont=Sauce_Code_Pro_Nerd_Font_Complete_Mono:h13
"set guifont=FuraCodeNerdFontComplete-Retina:h13

  menu Utils.NERDTree <F2>
  menu Utils.NERDTerm <F4>
  menu Utils.Find <F12>
  menu Utils.Buffers <F3>

  menu Utils.Code.Fix <F9>
  menu Utils.Code.Goto :YcmCompleter GoTo
  menu Utils.Code.Goto\ Declaration <F7>
  menu Utils.Code.Goto\ Definition :YcmCompleter GoToDefinition
  menu Utils.Code.Goto\ Implementation :YcmCompleter GoToImplementation
  menu Utils.Code.Goto\ References :YcmCompleter GoToReferences
  menu Utils.Code.Goto\ Type :YcmCompleter GoToType
  menu Utils.Code.Imports <F10>
  menu Utils.Code.Tags <F4>

  menu Utils.Docs.Dash <F1>
  menu Utils.Docs.Javadoc <F16>


  menu Utils.Git.Blame :Git blame
  menu Utils.Git.Commits <F11>
  menu Utils.Git.Commit :Gcommit
  menu Utils.Git.Delete :Gdelete
  menu Utils.Git.Diff :Gvdiff
  menu Utils.Git.Log :Gclog
  menu Utils.Git.Merge :Gmerge
  menu Utils.Git.Move\.\.\. :Gmove 
  menu Utils.Git.Pull :Gpull
  menu Utils.Git.Push :Gpush
  menu Utils.Git.Rename\.\.\. :Grename 
  menu Utils.Git.Status :G

  menu Utils.Vim.Hist <F5>
  menu Utils.Vim.HLS <F13>
  menu Utils.Vim.Marks <F6>
  menu Utils.Vim.Undos <F8>

  menu Go.CodeGen.FillStruct :GoFillStruct<CR>
  menu Go.CodeGen.Keyify :GoKeyify<CR>
  "
  menu Go.Exec.Build :GoBuild<CR>
  menu Go.Exec.Run :GoRun<CR>
  menu Go.Exec.Install :GoInstall<CR>
  menu Go.Exec.Lint :GoLint<CR>
  menu Go.Exec.MetaLinter :GoMetaLinter<CR>
  "
  menu Go.Alternate :GoAlternate<CR>
  menu Go.Callees :GoCallees<CR>
  "
  menu Go.Coverage.Coverage :GoCoverage<CR>
  menu Go.Coverage.CoverageBrowser :GoCoverageBrowser<CR>
  menu Go.Coverage.Clear :GoCoverageClear<CR>
  menu Go.Coverage.Toggle :GoCoverageToggle<CR>
  "
  menu Go.Debug.Start :GoDebugStart<CR>
  menu Go.Debug.Step :GoDebugStep<CR>
  menu Go.Debug.Stop :GoDebugStop<CR>
  menu Go.Debug.DefStack :GoDefStack<CR>
  menu Go.Debug.DefPop :GoDefPop<CR>
  "
  menu Go.Def :GoDef<CR>
  menu Go.Describe :Goscribe<CR>
  menu Go.Doc :GoDoc<CR>
  menu Go.DocBrowser :GoDocBrowser<CR>
  menu Go.Drop :GoDrop<CR>
  menu Go.ErrCheck :GoErrCheck<CR>
  menu Go.Format :GoFormat<CR>
  "
  menu Go.Goto.Definition :GoDef<CR>
  menu Go.Goto.TypeDefinition :GoDefType<CR>
  "
  menu Go.Implements :GoImplements<CR>
  menu Go.Import :GoImport<CR>
  menu Go.Impl :GoImpl<CR>
  menu Go.Info :GoInfo<CR>
  menu Go.Referrers :GoReferrers<CR>
  menu Go.RemoveTags :GoRemoveTags<CR>
  menu Go.Rename :GoRename<CR>
  "
  menu Go.Test.Test :GoTest<CR>
  menu Go.Test.Func :GoTestFunc<CR>
  menu Go.Test.Vet :GoVet<CR>

  map <F1> :Dash<CR>

  map <F2> :NERDTree<CR>

  map <F3> :Buffers<CR>

  map <F4> :NERDTermToggle<CR>

  map <F5> :History<CR>

  map <F6> :Marks<CR>



  map <F9> :'x,.d<CR>

  map <F10> :UndotreeToggle<CR>

  map <F11> :BCommits<CR>

  "yanks word under cursor into register z, then invoke Rg with that
  map <F12> "zyiw:Rg z<CR>

  map <F13> :set hls!<CR>


  "map <S-F2> :ScreenShell<CR>
  "map <F5> :BuffergatorOpen<CR>
  "map <F6> :set number!
  "map <F7> :set hls!
  "map <F8> :SyntasticCheck<CR>
  "map <F9> "*y
  "map <F10> "+gP
  "map <C-F6> :tabp
  "map <C-F7> :tabn

  set statusline+=%#warningmsg#
 " set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  set statusline+=%{FugitiveStatusline()}

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
  " java disabled so as not to clash with YouCompleteMe
  let g:syntastic_java_checkers = []
  " yamllint is installed with brew
  let g:syntastic_yaml_checkers = ['yamllint']

  nnoremap <S-F6> :m .-2<CR>==
  nnoremap <S-F7> :m .+1<CR>==
  inoremap <S-F6> <ESC>:m .-2<CR>==gi
  inoremap <S-F7> <ESC>:m .+1<CR>==gi
  vnoremap <S-F6> <ESC>:m '<-2<CR>gv=gv
  vnoremap <S-F7> <ESC>:m '<+1<CR>gv=gv

  "set rtp+=~/.vim/tabnine/tabnine-vim

  runtime ftplugin/man.vim

endif
