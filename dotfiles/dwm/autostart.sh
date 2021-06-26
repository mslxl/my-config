#!/bin/sh
xmodmap $HOME/.dwm/.xmodmap
feh --bg-scale $HOME/.wallpaper
picom -b &
$HOME/.dwm/dwm-status.sh &

# Wait
{
	sleep 3
	pulseaudio --start &
	nm-applet &
	tmux new -d -s v2ray 'v2ray -c ~/v2ray.json' &
	fcitx5 -d &
	pcmanfm -d &
}&
