#!/bin/sh
for i in 1 4 16 ; do
    ( while true ; do ps -ef | grep -v grep | grep -qF $HOME/.xmonad/xmonad- && break ; sleep $i ; done ; xmodmap ~/.Xmodmap ) &
done
goldendict &
true
