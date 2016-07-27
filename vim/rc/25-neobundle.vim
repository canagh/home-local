if has('unix') && isdirectory(expand('~/.ssh'))

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }


NeoBundle 'tpope/vim-surround'
NeoBundle 'Align'

" history
NeoBundle 'vim-scripts/repeat.vim'
NeoBundleLazy 'mbbill/undotree', { 'autoload': { 'commands': ['UndotreeToggle'] }} " {{{
nnoremap <silent> <Leader>gu :UndotreeToggle<CR>
" }}}
" NeoBundleLazy "sjl/gundo.vim", { "autoload": { "commands": ['GundoToggle'] }} " {{{
" nnoremap <Leader>gu :GundoToggle<CR>
" " }}}

" unite {{{
NeoBundle 'Shougo/unite.vim'
" let g:unite_enable_start_insert = 1
" The prefix key.
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
" unite.vim keymap
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]F :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]vr :UniteResume<CR>/"

NeoBundle 'Shougo/unite-outline', { 'depends' : 'Shougo/unite.vim' }
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

NeoBundle 'Shougo/vimfiler', { 'depends' : 'Shougo/unite.vim' }
let g:vimfiler_as_default_explorer = 1
au vimrc FileType vimfiler nnoremap q <Plug>(vimfiler_exit)
au vimrc FileType vimfiler nnoremap Q :<C-U>quit<CR>
" }}}

NeoBundle 'bling/vim-airline' " {{{
" Q. The statusline does not appear until I create a split.
" A. This is the default setting of |laststatus|.  If you want it to appear all the time, add the following to your vimrc: >
set laststatus=2
" to avoid an error on the anzu.vim's extension
let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr} %3l:%3c'
" }}}

" neocomplete {{{
if has('lua')
    NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
if neobundle#is_installed('neocomplete.vim')
    " for neocomplete
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#use_vimproc = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
endif
" }}}

" neosnippet " {{{
NeoBundleLazy 'Shougo/neosnippet',          { 'autoload' : {'insert' : '1'} }
NeoBundleLazy 'Shougo/neosnippet-snippets', { 'autoload' : {'insert' : '1'} }
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\  "\<Plug>(neosnippet_expand_or_jump)"
\ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\  "\<Plug>(neosnippet_expand_or_jump)"
\ : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" user defined snippets
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
" }}}

NeoBundleLazy 'ujihisa/neco-look',    { 'autoload' : {'insert' : '1'} }
" }}}

" jump
NeoBundle 'osyo-manga/vim-anzu' "{{{
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
let g:airline#extensions#anzu#enabled = 1
let g:anzu_search_limit = 1000
" }}}
NeoBundle 'matchit.zip'
" NeoBundle 'Lokaltog/vim-easymotion' " 使ってない
" NeoBundle 'camelcasemotion'

NeoBundle 'soramugi/auto-ctags.vim'

NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'vim-scripts/dbext.vim'

" marking
NeoBundle 'nathanaelkane/vim-indent-guides' " {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
" }}}
"NeoBundle 'cohama/vim-insert-linenr'

NeoBundle 'thinca/vim-quickrun' " {{{
let g:quickrun_config = {}
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "jceb/vim-hier"
NeoBundle "dannyob/quickfixstatus"
" }}}

"NeoBundle 'YankRing.vim' " {{{
"let g:yankring_history_dir = '$HOME/.vim'
"nnoremap <silent> <Leader>yu :YRShow<CR>
"nnoremap <Leader>y/ :YRSearch<Space>
" }}}

" parentheses
NeoBundle 'luochen1990/rainbow'
let g:rainbow_active = 1

" colorscheme
"NeoBundle 'desert256.vim'
NeoBundle 'w0ng/vim-hybrid'

NeoBundleLazy 'tyru/open-browser.vim', { 'autoload': { 'mappings': '<Plug>(openbrowser-' } } " {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
NeoBundle 'sudo.vim'
NeoBundle 'tyru/autochmodx.vim'
NeoBundle 'thinca/vim-template'

NeoBundle 'rkitover/vimpager'

NeoBundle 'solorab/cpl.vim'
NeoBundle 'wting/rust.vim'

NeoBundle 'glidenote/octoeditor.vim'
let g:octopress_path = '~/local/blog'

" syntax checker
NeoBundle "scrooloose/syntastic"
let g:syntastic_mode_map = {
\    'mode': 'passive',
\    'active_filetypes': ['cpp'],
\ }
let g:syntastic_cpp_checkers = ['cppcheck', 'clang-check']

" language {{{

" markdown
NeoBundleLazy 'tpope/vim-markdown', { "autoload" : { "filetypes" : [ "markdown" ] } }
"NeoBundle 'plasticboy/vim-markdown'
"NeoBundle 'suan/vim-instant-markdown'

" c++
"NeoBundle 'Rip-Rip/clang_complete'
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight', { "autoload" : { "filetypes" : [ "cpp" ] } } " for c++11
NeoBundleLazy 'vim-jp/cpp-vim',         { "autoload" : { "filetypes" : [ "cpp" ] } } " for c++11
" NeoBundleLazy 'cpp.vim',                { "autoload" : { "filetypes" : [ "cpp" ] } } " for stl
NeoBundleLazy 'vim-scripts/opengl.vim', { "autoload" : { "filetypes" : [ "cpp", "c" ] } }
NeoBundleLazy 'kana/vim-smartchr',      { "autoload" : { "filetypes" : [ "cpp", "c" ] } } " 現在 c,cpp でしか使ってない
" NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {'insert' : '1'} } " 併用する? http://ac-mopp.blogspot.jp/2013/07/vim-smart-input.html
NeoBundleLazy 'solorab/sdl2.vim', { "autoload" : { "filetypes" : [ "cpp", "c" ] } }

" haskell
NeoBundleLazy 'ujihisa/neco-ghc',            { "autoload" : { "filetypes" : [ "haskell" ] } }
"NeoBundleLazy 'lukerandall/haskellmode-vim', { "autoload" : { "filetypes" : [ "haskell" ] } } " {{{
"let g:haddock_browser='firefox' " this must be here, not after/
" }}}
NeoBundleLazy 'eagletmt/ghcmod-vim',         { "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'bitc/vim-hdevtools',          { "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'eagletmt/unite-haddock',      { "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'dag/vim2hs',                  { "autoload" : { "filetypes" : [ "haskell" ] } }
"NeoBundleLazy 'dan-t/vim-hsimport',          { "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'Twinside/vim-haskellFold',    { "autoload" : { "filetypes" : [ "haskell" ] } }

" schele
" gauche
"NeoBundle 'aharisu/vim_goshrepl'
"NeoBundle 'aharisu/vim-gdev'

" brainfuck
NeoBundleLazy 'kmyk/brainfuck-highlight.vim', { 'autoload' : { 'filetypes' : 'brainfuck' } }

" python
NeoBundleLazy 'kevinw/pyflakes-vim',     { "autoload" : { "filetypes" : [ "python" ] } }
" NeoBundleLazy 'sontek/rope-vim',                { "autoload" : { "filetypes" : [ "python" ] } }
NeoBundleLazy 'lambdalisue/vim-django-support', { "autoload" : { "filetypes" : [ "python" ] } }
NeoBundleLazy 'vim-scripts/Pydiction', { "autoload" : { "filetypes" : [ "python" ] } }

" html
NeoBundleLazy 'mattn/zencoding-vim', { "autoload" : { "filetypes" : [ "html" ] } }
NeoBundleLazy 'othree/html5.vim',    { "autoload" : { "filetypes" : [ "html" ] } }

" css
NeoBundleLazy 'hail2u/vim-css3-syntax', { "autoload" : { "filetypes" : [ "css" ] } }
" NeoBundle 'css_color.vim' " 重すぎ

" coffeescript
NeoBundleLazy 'kchmck/vim-coffee-script', { "autoload" : { "filetypes" : [ "coffee" ] } }

" haxe
NeoBundleLazy 'jdonaldson/vaxe', { "autoload" : { "filetypes" : [ "haxe" ] } }
"NeoBundle 'MarcWeber/vim-haxe'

" idris
NeoBundleLazy 'idris-hackers/idris-vim', { "autoload" : { "filename_patterns" : "\.idr$" } }

" nimrod
NeoBundleLazy 'zah/nimrod.vim', { "autoload" : { "filename_patterns" : "\.nim$" } }

" coq
NeoBundleLazy 'jvoorhis/coq.vim', { 'autoload' : { 'filetypes' : [ 'coq', 'verilog' ] }}
NeoBundleLazy 'CoqIDE', { 'autoload' : { 'filetypes' : [ 'coq', 'verilog' ] }}
" NeoBundleLazy 'eagletmt/coqtop-vim', { 'autoload' : { 'filetypes' : [ 'coq', 'verilog' ] }}

" arduino
NeoBundleLazy "sudar/vim-arduino-syntax", { 'autoload' : { 'filename_patterns' : '\.ino$' } }

" piet
NeoBundleLazy 'mmisono/piet.vim', { 'autoload' : { 'filename_patterns' : '\.piet$' } }

" }}}

endif
