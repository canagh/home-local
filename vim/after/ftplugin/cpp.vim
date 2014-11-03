if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

source $HOME/.vim/bundle/opengl.vim/syntax/opengl.vim

" 演算子の間に空白を入れる
"inoremap <buffer><expr> / smartchr#one_of('/', '// ', '/// ')
" 「->」は入力しづらいので、..で置換え
"inoremap <buffer><expr> . smartchr#loop('.', '->', '...')
" if, for, while, switch文直後の(は自動で間に空白を入れる
"inoremap <buffer><expr> ( search('\<\(\if\<bar>for\<bar>while\<bar>switch\)\%#', 'bcn')? ' (': '('
