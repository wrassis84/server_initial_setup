" This is the VIM configuration file.
" After modify, run ':so %' to reload them.
" (This works only if .vimrc is the current file being edited)
" Out of .vimrc, run ':source ~/.vimrc' or simply ':so ~/.vimrc' or press F12

" Enables Syntax color:
syntax on

"Enables a minibar at bottom of page:
set laststatus=2

"Enables IncrementedSearch, HighLightedSearch, IgnoreCase and SmartCaSe:
set is hls ic scs magic	

"Enables ShowMatch - show the match braces, curly braces and parenthesis:
set sm			

" Enables AutoWrite (Auto saving):
set aw

" Enables AutoIndentation of code:
set ai

" Convert existing TABs in spaces:
"retab

" Enables ruler to show cursor position (row, column):
set ruler

" Show the running command:
set showcmd

" Set line wrap:
set textwidth=80

" Set the Backspace behavior:
"set bs=0

" Flash the screen to advertising (Instead bip):
set visualbell

" Force line wrap: 
"set wrap

" Enables AutoComplete with TAB like Bash:
set wildmode=longest,list:full

" Setting the colorscheme and row and colunms highlighting:
colorscheme desert
set cursorcolumn
hi CursorColumn term=bold cterm=bold ctermbg=238
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=238

" Setting highlight for Vagrant files:
au BufNewFile,BufRead Vagrantfile set ft=ruby

" Syntax highlighting and indentation for YAML files:
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0

" Syntax highliting for JSON files:
au BufNewFile,BufRead *.json set ft=json

" Syntax highliting for HTML files:
au BufNewFile,BufRead *.html set ft=html
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab

" Enable auto completion menu after pressing TAB:
set wildmenu

" Enables mouse on VIM:
set mouse=a

" Map the key F6 to toggle line numbering:
map <F6> <Esc>:set nu!<cr>

" Map the keys F2 to clean search history:
"nno <F2> <Esc>:let @/=""<CR>

" Map the key F9 to save the current file:
nmap <F9> <Esc>:w<cr>
vmap <F9> <Esc>:w<cr>
imap <F9> <Esc>:w<cr>

" Map the key F10 to save and quit Vim:
nmap <F10> <Esc>:wq<cr>
vmap <F10> <Esc>:wq<cr>
imap <F10> <Esc>:wq<cr>

" Map the key F12 to reload the source file:
nmap <F12> <Esc>:source ~/.vimrc<cr>
vmap <F12> <Esc>:source ~/.vimrc<cr>
imap <F12> <Esc>:source ~/.vimrc<cr>

" Map the keys CTRL+DOWN to move lines down (on normal mode):
nmap <C-Down> ddp

" Map the keys CTRL+UP to move lines up (on normal mode):
nmap <C-Up> ddkP

" Map F3 to toggle highlight search:
nnoremap <F3> :set hlsearch!<CR>

" Creating a function for comment code in blocks (on normal or visual mode):
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
        echo ":( No comment leader found for filetype!"
    end
endfunction

" Map the keys \+<space> to toggle comment selected lines:
" NOTE: On VIM editor the default <leader> key is '\' key.
" But with - :let mapleader = "," - you can map other key as <leader>.
" In this case ',' (comma) would be the new <leader> key. ;)
nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>

# Insert custom header for shell files:
au bufnewfile *.sh 0r ~/.vim/header.sh