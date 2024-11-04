#!/bin/sh
#
# .xsession
#

export WINDOW_MANAGER="/usr/bin/e16 -t c2h8"

#export LANG=C
#export LC_CTYPE="ja_JP.UTF-8"
#export LC_CTYPE="ja_JP.eucJP"
#export XMODIFIERS="@im=kinput2"

xrdb -merge $HOME/.Xdefaults

#gmix -i
#fetchmail -d 300
xset +dpms
xset dpms 120 120 120
xmodmap - < $HOME/.xmodmap.rc
#xmodmap -e 'keycode 116 = Kanji'  # right Windows key

if [ "x$HOSTNAME" = "xhork" -o `cat /etc/hostname 2> /dev/null` = "hork" ]; then
  setxkbmap -option compose:menu
fi

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
