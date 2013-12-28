#!/usr/bin/zsh

# http://qiita.com/mollifier/items/14bbea7503910300b3ba
function zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

function zcompile-all() {
    rmdust -r ~/.antigen ~/share/{z,}sh
    for f in ~/.zsh{env,rc} ~/.z{profile,log{in,out}} ~/.antigen/**/* ~/share/{z,}sh/**/* ; do
        zcompile "$f" && echo zcompile \""$f"\"
    done
}

function zcompile-all-del() {
    updatedb.home
    locate.home .zwc | grep \\.zwc$ | xargs -d \\n del
}

via-o2on() {
    o2on_port=8020
    command="$1"
    shift
    if lsof -i:$o2on_port | grep -iq 'o\(py\)\?2on' ; then
        env http_proxy=http://localhost:$o2on_port "$command" "$@"
    else
        "$command" "$@"
    fi
}
alias    '2ch-get'='via-o2on `which -p 2ch-get`'
alias '2ch-browse'='via-o2on `which -p 2ch-browse`'
alias ch=2ch-browse
alias chn='2ch-browse -n'
alias chg='2ch-get -d'
alias chgn='2ch-get -d -n'
alias chgq='2ch-get -q'
alias chf=2ch-format
alias chp=2ch-post
alias chu=2ch-utils

vimrc() { $VISUAL ~/.vimrc ; }

alias fd="env ANSICOLOR=1 fd"
hsenv-activate() { . ${@:-$PWD}/.hsenv/bin/activate }

alias talk='ojtalk -vname mei_normal'
alias talk-angry='ojtalk -vname mei_angry'
alias talk-bashful='ojtalk -vname mei_bashful'
alias talk-happy='ojtalk -vname mei_happy'
alias talk-sad='ojtalk -vname mei_sad'

alias notify='notify-send -i terminal'

alias gitignored='git ls-files -o -i --exclude-standard'

gosh() {
    if [ $# -eq 0 ] && which gosh-rl >/dev/null ; then
        gosh-rl "$@" # gosh-rl do not recognize the options
    elif which rlwrap >/dev/null ; then
        rlwrap -pBLUE gosh "$@"
    else
        gosh "$@"
    fi
}

vf() {
    vim -c 'au FileType vimfiler nnoremap <buffer> q :<C-u>quit<CR>' \
        -c 'au FileType vimfiler nnoremap <buffer> Q :<C-u>quit<CR>' \
        -c ':VimFiler -status '"$*"
}

MLOCATE_HOME_DB=$HOME/var/home.mlocate.db
updatedb-home() {
	updatedb --database-root $HOME --output $MLOCATE_HOME_DB --require-visibility 0 $@
}
locate-home() {
	locate --database $MLOCATE_HOME_DB $@
}

w3m-Thtml() { w3m -T text/html "$@" }


## power management
alias suspend=pm-suspend
alias hibernate=pm-hibernate
alias powersave=pm-powersave
alias suspend-hybrid=pmsuspend-hybrid

apt-add-japanese-repository() {
    # https://ubuntulinux.jp/japanese
    wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add -
    wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add -
    wget https://www.ubuntulinux.jp/sources.list.d/oneiric.list -O /etc/apt/sources.list.d/ubuntu-ja.list
    apt-get update
    apt-get upgrade
    apt-get install ubuntu-desktop-ja
}

url_quote() {
    if [ $# = 0 ]
    then echo -n "`cat`"
    else echo -n "$@"
    fi | python3 -c 'import sys, urllib.parse as url ; print(url.quote(sys.stdin.read()))'
}
duckduckgo() { echo http://duckduckgo.com/\?q=`echo $@ | url_quote` }
alias ddg=duckduckgo
wikipedia() {
    local lang
    lang=en
    case "$1" in
        ja | japan | jp ) lang=ja ; shift ;;
        -- | en | english ) shift ;;
    esac
    echo http://${lang}.wikipedia.org/wiki/`echo $@ | url_quote`
}
alias wikip=wikipedia
alias wkp=wikipedia
google() {
    local lang
    lang=com
    case "$1" in
        jp | co.jp | japan | ja ) lang=co.jp ; shift ;;
        -- | en | com | english ) shift ;;
    esac
    echo http://www.google.$lang/search\?q=`echo $@ | url_quote`
}
alias ggl=google
bing() { echo http://www.bing.com/search\?q=`echo $@ | url_quote` }
weblio() {
    local type
    type=ejje
    case "$1" in
        ejje ) type=$1 ; shift ;;
    esac
    echo http://${type}.weblio.jp/content/`echo $@ | url_quote`\#main
}
hoogle() { echo http://www.haskell.org/hoogle/\?hoogle=`echo $@ | url_quote` }
github() { echo git@github.com:"$1".git }
axfc() {
    local elem num
    case "$#" in
        1 )
            elem=`echo $1 | sed -e 's/_.*//'`
            num=`echo $1 | sed -e 's/.*_//'`
            ;;
        2 )
            elem=$1
            num=$2
            ;;
    esac
    [ -n "$elem" -a -n "`echo "$num" | grep '^[[:digit:]]\+$'`" ] || error "$type"': wrong format argument: '"$*"
    echo http://www1.axfc.net/uploader/"$elem"/so/"$num"
}
nicovideo() {
    local num
    num=`echo "$1" | grep '^\(sm\)\?[[:digit:]]\+$'`
    [ "$num" ] || error "$type"': wrong format argument: '"$1"
    echo http://www.nicovideo.jp/watch/sm"$num"
}

bddg() { $BROWSER `duckduckgo "$@"` }
bwkp() { $BROWSER `wikipedia  "$@"` }
bggl() { $BROWSER `google     "$@"` }

hide()   { local i ; for i in "$@" ; do mv "$i" "$i".hidden ; done }
unhide() { local i ; for i in "$@" ; do mv "$i".hidden "$i" ; done }

new-post()  { (cd ~/work/public/blog ; rake new_post) }
edit-post() {
    local prefix file
    prefix=~/work/public/blog/source/_posts
    file="`ls $prefix | canything`"
    [ "$file" ] && $VISUAL $prefix/$file
}

diary() {
    local run prefix name
    prefix=~/var/diary
    run=$VISUAL
    case "$1" in -p | --path ) run=echo ; shift ;; esac
    if [[ $# == 0 ]] ; then
        name=`date +%Y/%m/%d`
    elif [[ $# == 1 ]] && [[ "$1" =~ [^0-9/] ]] ; then
        case "$1" in
            ????/??/?? ) name=$1 ;;
                 ??/?? ) name=`date +%Y`/$1 ;;
                    ?? ) name=`date +%Y/%m`/$1 ;;
        esac
    fi
    [ ! "$name" ] && name=`date +%Y/%m/%d -d "$*"`
    $run $prefix/$name.md
}
