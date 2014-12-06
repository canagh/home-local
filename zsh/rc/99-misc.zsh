local last_command
function preexec-foo {
    case "$3" in
        comp | comp\ * ) speak 'こんぱいるっ' ;;
        jdge | jdge\ * ) speak 'じゃっじっ' ;;
        ghci | ghci\ * | runghc | runghc\ * | runhaskell | runhaskell\ * ) speak 'はすはす' ;;
    esac
    last_command="$3"
}
function precmd-foo {
    local ret=$?
    if [ "$last_command" -a $ret != 0 ] ; then
        speak 'こまんど しっぱいしたよっ: '"$last_command"
        case `date +%H` in
            00 | 01 | 02 ) speak 'もう ねよう' ;;
        esac
    fi
    last_command=
}
autoload add-zsh-hook
add-zsh-hook preexec preexec-foo
add-zsh-hook precmd  precmd-foo
REPORTTIME=8
