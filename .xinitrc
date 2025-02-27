#!/bin/bash
# Taken from:
#	https://raw.github.com/kaihendry/Kai-s--HOME/master/.xinitrc
#
# for terminus font in Archlinux :(
#xset +fp /usr/share/fonts/local
#xset fp rehash

xset -b # disable bell
eval `/usr/bin/ssh-agent`

if test -f /usr/lib/openssh/x11-ssh-askpass # Archlinux
then
	SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null
fi

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
	SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

# 1280x720 = 720p X220
#hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &

#xrdb -merge $HOME/.Xresources
xrdb -merge $HOME/.Xdefaults
#xmodmap ~/.Xmodmap
#setxkbmap -layout en -option ctrl:nocaps

#hash chromium && chromium &

display -window root ~/.wallpaper.jpg

while true
do
	LOCALTIME=$(date +%Z\=%Y-%m-%dT%H:%M)
	OTHERTIME=$(TZ=Europe/London date +%Z\=%H:%M)

	xsetroot -name "$HOSTNAME $IP $VOL $TEMP $LOCALTIME $OTHERTIME"
	
	sleep 20s
done &

exec $HOME/bin/dwm
