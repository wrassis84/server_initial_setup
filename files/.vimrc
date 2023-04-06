" This is the VIM configuration file.
" After modify, run ':so %' to reload them.
" (This works only if .vimrc is the current file being edited)
" Out of .vimrc, run ':source ~/.vimrc' or simply ':so ~/.vimrc'

" -----------------------------------------------
" Syntax and Identation
" -----------------------------------------------
" Enable Syntax color:
syntax on
"Enable a minibar at bottom of page:
set laststatus=2
"Enable IncrementedSearch, HighLightedSearch, IgnoreCase and SmartCaSe:
set is hls ic scs magic	
"Enable ShowMatch - show the match braces, curly braces and parenthesis:
set showmatch	
" Enable AutoWrite (Auto saving):
set aw
" Enable AutoIdentation of code:
set autoindent
" Enable SmartIdentation of code:
set smartindent
" Store the last five thousand commands on history:
set history=5000
" Convert existing TABs in spaces:
"retab
" Enable ruler to show cursor position (row, column):
set ruler
" Show the running command:
set showcmd
" Set line wrap:
set textwidth=80
" Enable line numbering:
set number
" Highlight the line under cursor: 
"set cursorline
" Enable clipboard sharing between Vim and the graphical interface:
set clipboard=unnamedplus
" Convert TAB in SPACES:
set tabstop=2 softtabstop=2 expandtab shiftwidth=2
" Enable auto completion menu after pressing TAB:
set wildmenu
" Enable AutoComplete with TAB like Bash:
set wildmode=longest,list:full
" Enable colapsing or expanding of code:
setlocal foldmethod=syntax
setlocal foldlevel=99
nnoremap <space> za
" Enable mouse on VIM:
set mouse=a
" -----------------------------------------------

" -----------------------------------------------
" Colors:
" -----------------------------------------------
" Setting the colorscheme:
colorscheme pablo
" Setting highlight for Vagrant files:
"au BufNewFile,BufRead Vagrantfile set ft=ruby
" Syntax highlighting and indentation for YAML files:
"autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
" Syntax highliting for JSON files:
"au BufNewFile,BufRead *.json set ft=json
" Syntax highliting for HTML files:
"au BufNewFile,BufRead *.html set ft=html
"autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
" -----------------------------------------------

" -----------------------------------------------
" Map "leader"+t to open terminal below:
nnoremap <leader>t :below terminal<cr>
" -----------------------------------------------

" -----------------------------------------------
" Mapping for Function keys:
" -----------------------------------------------
" Map F3 to toggle highlight search:
nnoremap <F3> :set hlsearch!<cr>
vnoremap <F3> :set hlsearch!<cr>
inoremap <F3> :set hlsearch!<cr>
" Map the key F5 to execute code:
nnoremap <F5> <esc>:w<cr>:!%:p<cr>
vnoremap <F5> <esc>:w<cr>:!%:p<cr>
inoremap <F5> <esc>:w<cr>:!%:p<cr>
" Map the key F6 to toggle line numbering:
nnoremap <F6> <esc> :set nu!<cr>
vnoremap <F6> <esc> :set nu!<cr>
inoremap <F6> <esc> :set nu!<cr>
" Map the key F9 to save the current file:
nnoremap <F9> <esc> :w<cr>
vnoremap <F9> <esc> :w<cr>
inoremap <F9> <esc> :w<cr>
" Map the key F10 to save and quit Vim:
nnoremap <F10> <esc> :wq<cr>
vnoremap <F10> <esc> :wq<cr>
inoremap <F10> <esc> :wq<cr>
" Map the key F12 to reload the source file:
nnoremap <F12> <esc> :source ~/.vimrc<cr>
vnoremap <F12> <esc> :source ~/.vimrc<cr>
inoremap <F12> <esc> :source ~/.vimrc<cr>
" -----------------------------------------------

" -----------------------------------------------
" Map the keys CTRL+d to move lines down:
nmap <c-d> ddp==
vmap <c-d> ddp==
imap <c-d> ddp==
" Map the keys CTRL+u to move lines up:
nmap <c-u> ddkP==
vmap <c-u> ddkP==
imap <c-u> ddkP==
" -----------------------------------------------

" -----------------------------------------------
" Load a customize header for .sh files:
" NOTE: the "header.sh" file must be located on "$HOME/.vim/" directory.
au bufnewfile *.sh 0r $HOME/.vim/header.sh
" -----------------------------------------------
 
" -----------------------------------------------
" Function for comment code in blocks (on normal or visual mode):
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "Java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "Ruby": '#',
    \   "Rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \   "yaml": '#',
    \   "yml": '#',
    \   "tf": '#',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo ":( No comment leader found for this filetype!"
    end
endfunction
" Map the keys \+<space> to toggle comment selected lines:
" NOTE: On VIM editor the default <leader> key is '\' key.
" But with -> :let mapleader = "," -> you can map other key as <leader>.
" In this case ',' (comma) would be the new <leader> key. ;)
nnoremap <leader><space>:call ToggleComment()<cr>
vnoremap <leader><space>:call ToggleComment()<cr>
" -----------------------------------------------

" -----------------------------------------------
" Function for replace a word under cursor:
function ReplaceAll(rtype)
  let word = expand('<cword>')
  if !empty(word)
    let rword = input('Replace "' . word . '" for: ')
    if !empty(rword)
      let lin = line('.')
      if a:rtype == 'all'
      	execute '%s/' . word . '/' . rword . '/g'
      elseif a:rtype == 'line'
      	execute 's/' . word . '/' . rword . '/g'
      endif
      execute lin
    endif
  endif
endfunction
" Map CTRL-s+a to replace a word under cursor in all text:
nnoremap <c-s>a :call ReplaceAll('all')<cr>
" Map CTRL-s+l to replace a word under cursor in line:
nnoremap <c-s>l :call ReplaceAll('line')<cr>
" -----------------------------------------------

" -----------------------------------------------
" Toggle case:
" ~     : Changes the case of current character.
" guu   : Change current line from upper to lower.
"map <leader>uu guu<cr>
" gUU   : Change current LINE from lower to upper.
"map <leader>UU gUU<cr>
" guw   : Change to end of current WORD from upper to lower.
"map <leader>lw guw<cr>
" guaw  : Change all of current WORD to lower.
"map <leader>l guaw<cr>
" gUw   : Change to end of current WORD from lower to upper.
"map <leader>UW guw<cr>
" gUaw  : Change all of current WORD to upper.
"map <leader>U gUaw<cr>
" g~~   : Invert case to entire line.
"map <leader>~~ g~~<cr>
" g~w   : Invert case to current WORD.
"map <leader>~w g~w<cr>
" guG   : Change to lowercase until the end of document.
" gU)   : Change until end of sentence to upper case.
" gu}   : Change to end of paragraph to lower case.
" gU5j  : Change 5 lines below to upper case.
" gu3k  : Change 3 lines above to lower case.
" g~$   : Toggle case of all characters to end of line.
" ggVGu : To convert all text to lowercase in vim.
map <leader>Gu ggVGu<cr>
" ggVGU : To convert all text to uppercase in vim.
map <leader>GU ggVGU<cr>