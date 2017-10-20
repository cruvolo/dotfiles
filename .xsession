#!/bin/sh
#
# .xsession
#

export WINDOW_MANAGER=/usr/bin/e16

#export LANG=C
#export LC_CTYPE="ja_JP.UTF-8"
#export LC_CTYPE="ja_JP.eucJP"
#export XMODIFIERS="@im=kinput2"

xrdb -merge $HOME/.Xdefaults

#gmix -i
#fetchmail -d 300
xset dpms 300 600
xmodmap - < $HOME/.xmodmap.rc
#xmodmap -e 'keycode 116 = Kanji'  # right Windows key

#kinput2-wnn -wnn &
#licq &
#xscreensaver &
#x0rfbserver > /dev/null 2>&1 &

#enlightenment &
#exec gnome-panel
#mate-panel &
#caja &

gkrellm &

xsetroot -solid black

#exec $WINDOW_MANAGER
exec mate-session
