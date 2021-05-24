set nocompatible
filetype off

" on initialise Vundle au demarrage (installateur et gestionnaire de plugins)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'morhetz/gruvbox'
Plugin 'dense-analysis/ale'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'tomasr/molokai'
Plugin 'pangloss/vim-javascript'
Plugin 'altercation/solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'zxqfl/tabnine-vim'
Plugin '907th/vim-auto-save'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" fin des plugins
call vundle#end()

" on initialise vim-plug
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'wojciechkepka/bogster'
Plug 'tweekmonster/impsort.vim'  " color and sort import
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

execute pathogen#infect()

" parametres de base overall : utf-8, affichage des numeros de ligne, theme de couleurs...
filetype plugin indent on
set encoding=utf-8
set nu
set showcmd
syntax on
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
let g:gruvbox_improved_strings=1
colorscheme gruvbox
set bg=dark
set clipboard=unnamedplus
autocmd BufWritePre * %s/\s\+$//e
set mouse=a
let g:jedi#completions_enabled = 1
let g:EclimCompletionMethod = 'omnifunc'
let g:jedi#auto_initialization = 1
set foldmethod=indent

"Remove all trailing whitespace by pressing F5
nnoremap <F7> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" pour les fichiers python uniquement
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let python_highlight_all=1

" parametres de base pour syntastic (recommandes)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" on met syntastic en mode passif silencieux par defaut
" si on veut checker la syntaxe, on presse F2 ou F3 et on obtient les erreurs possibles
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }

" path to your python 
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" raccourcis pour quitter Vim plus rapidement (tout mode de sortie possible)
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:qa!<cr>
nnoremap <C-q> :qa!<cr>

" on active par defaut le fly mode de l'auto-pairs
let g:AutoPairsFlyMode = 1

" on quitte le mode insert le plus vite possible
:imap jj <Esc>
:imap kk <Esc>
:imap xx <Esc>

" parametres de base pour le plugin jedi (todo)
let g:jedi#environment_path = "/usr/bin/python3.9"
let g:jedi#completions_enabled = 1

noremap <F2> :SyntasticCheck<CR>
noremap <F1> :SyntasticToggleMode<CR>
nmap <F3> :TagbarToggle<CR>
nmap <F6> :NERDTreeToggle<CR>
" Copy to 'clipboard registry'
vmap <C-c> "*y
" Select all text
nmap <C-a> ggVG
map gm :call cursor(0, virtcol('$')/2)<CR>

let g:auto_save = 1

nnoremap o o<Esc>
nnoremap O O<Esc>

" ale options
let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
let g:ale_list_window_size = 4
let g:ale_sign_column_always = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = '1'
" Options are in .pylintrc!
highlight VertSplit ctermbg=253
let g:ale_sign_error = '‼'
let g:ale_sign_warning = '∙'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_save = '1'
nmap <silent> <C-M> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Impsort option
hi pythonImportedObject ctermfg=127
hi pythonImportedFuncDef ctermfg=127
hi pythonImportedClassDef ctermfg=127

" Remove all trailing whitespace by pressing C-S
nnoremap <C-S> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" move between defs python:
nnoremap [[ [m
nnoremap ]] ]m

nnoremap <silent><nowait> [ [[
nnoremap <silent><nowait> ] ]]

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> [ :<c-u>exe 'normal '.v:count.'[m'<cr>
    nnoremap <silent><nowait><buffer> ] :<c-u>exe 'normal '.v:count.']m'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType python call MakeBracketMaps()
augroup END

call deoplete#custom#var('tabnine', {
\ 'line_limit': 500,
\ 'max_num_results': 20,
\ })

let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Language:		GNU Assembler

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" storage types
syn match asmType "\.long"
syn match asmType "\.ascii"
syn match asmType "\.asciz"
syn match asmType "\.byte"
syn match asmType "\.double"
syn match asmType "\.float"
syn match asmType "\.hword"
syn match asmType "\.int"
syn match asmType "\.octa"
syn match asmType "\.quad"
syn match asmType "\.short"
syn match asmType "\.single"
syn match asmType "\.space"
syn match asmType "\.string"
syn match asmType "\.word"

syn match asmIdentifier		"[a-z_][a-z0-9_]*"
syn match asmLabel		"[a-z_][a-z0-9_]*:"he=e-1

syn match asmDecimal		"\<0\+[1-7]\=\>"	 display
syn match asmDecimal		"\<[1-9]\d*\>"		 display
syn match asmOctal		"\<0[0-7][0-7]\+\>"	 display
syn match asmHexadecimal	"\<0[xX][0-9a-fA-F]\+\>" display
syn match asmBinary		"\<0[bB][0-1]\+\>"	 display

syn match asmFloat		"\<\d\+\.\d*\%(e[+-]\=\d\+\)\=\>" display
syn match asmFloat		"\.\d\+\%(e[+-]\=\d\+\)\=\>"	  display
syn match asmFloat		"\<\d\%(e[+-]\=\d\+\)\>"	  display
syn match asmFloat		"[+-]\=Inf\>\|\<NaN\>"		  display

syn match asmFloat		"\%(0[edfghprs]\)[+-]\=\d*\%(\.\d\+\)\%(e[+-]\=\d\+\)\="    display
syn match asmFloat		"\%(0[edfghprs]\)[+-]\=\d\+\%(\.\d\+\)\=\%(e[+-]\=\d\+\)\=" display
" Avoid fighting the hexadecimal match for unicorn-like '0x' prefixed floats
syn match asmFloat		"\%(0x\)[+-]\=\d*\%(\.\d\+\)\%(e[+-]\=\d\+\)\="		    display

syn match asmCharacterEscape	"\\."    contained
syn match asmCharacter		"'\\\=." contains=asmCharacterEscape

syn match asmStringEscape	"\\\_."			contained
syn match asmStringEscape	"\\\%(\o\{3}\|00[89]\)"	contained display
syn match asmStringEscape	"\\x\x\+"		contained display

syn region asmString		start="\"" end="\"" skip="\\\\\|\\\"" contains=asmStringEscape

syn keyword asmTodo		contained TODO FIXME XXX NOTE

syn region asmComment		start="/\*" end="\*/" contains=asmTodo,@Spell

syn region asmComment		start="//" end="$" keepend contains=asmTodo,@Spell

syn match asmComment		"[#;!|].*" contains=asmTodo,@Spell

"syn match asmComment		"@.*" contains=asmTodo
"syn match asmComment		"^#.*" contains=asmTodo

" comment highlighting or use a specific, more comprehensive syntax file.

syn match asmInclude		"\.include"
syn match asmCond		"\.if"
syn match asmCond		"\.else"
syn match asmCond		"\.endif"
syn match asmMacro		"\.macro"
syn match asmMacro		"\.endm"

syn match asmDirective

syn case match

" The default methods for highlighting.  Can be overridden later
hi def link asmSection		Special
hi def link asmLabel		Label
hi def link asmComment		Comment
hi def link asmTodo		Todo
hi def link asmDirective	Statement

hi def link asmInclude		Include
hi def link asmCond		PreCondit
hi def link asmMacro		Macro

if exists('g:asm_legacy_syntax_groups')
  hi def link hexNumber		Number
  hi def link decNumber		Number
  hi def link octNumber		Number
  hi def link binNumber		Number
  hi def link asmHexadecimal	hexNumber
  hi def link asmDecimal	decNumber
  hi def link asmOctal		octNumber
  hi def link asmBinary		binNumber
else
  hi def link asmHexadecimal	Number
  hi def link asmDecimal	Number
  hi def link asmOctal		Number
  hi def link asmBinary		Number
endif
hi def link asmFloat		Float

hi def link asmString		String
hi def link asmStringEscape	Special
hi def link asmCharacter	Character
hi def link asmCharacterEscape	Special

hi def link asmIdentifier	Identifier
hi def link asmType		Type

let b:current_syntax = "asm"

unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
