#!/usr/bin/zsh

__2ch_bookmark_list=()

function() {
    __caching_policy() {
        [ ! -f "$1" ] || [ "`find "$1" -mmin +1`" ] # true => rebuild
    }
    local curcontext="$curcontext" update_policy
    zstyle -s ":completion:${curcontext}:" cache-policy update_policy
    [ "$update_policy" ] || zstyle ":completion:${curcontext}:" cache-policy __caching_policy
    if ( ! (( $+__2ch_bookmark_list_hot )) || _cache_invalid 2ch_bookmark_hot ) && ! _retrieve_cache 2ch_bookmark_hot ; then
        __2ch_bookmark_list_hot=( ${(@f)"$(~/var/2ch/bookmark_hot)"} )
    fi
    _store_cache 2ch_bookmark_hot __2ch_bookmark_list_hot
    __2ch_bookmark_list+=($__2ch_bookmark_list_hot)
}

function() {
    __caching_policy() {
        [ ! -f "$1" ] || [ "`find "$1" -mtime +1`" ] # true => rebuild
    }
    local curcontext="$curcontext" update_policy
    zstyle -s ":completion:${curcontext}:" cache-policy update_policy
    [ "$update_policy" ] || zstyle ":completion:${curcontext}:" cache-policy __caching_policy
    if ( ! (( $+__2ch_bookmark_list_cool )) || _cache_invalid 2ch_bookmark_cool ) && ! _retrieve_cache 2ch_bookmark_cool ; then
        __2ch_bookmark_list_cool=( ${(@f)"$(~/var/2ch/bookmark_cool)"} )
    fi
    _store_cache 2ch_bookmark_cool __2ch_bookmark_list_cool
    __2ch_bookmark_list+=($__2ch_bookmark_list_cool)
}

_describe -t bookmark bookmark __2ch_bookmark_list
