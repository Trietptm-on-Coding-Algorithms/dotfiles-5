xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 0,0,0,0,0,0,0
xcompmgr -n &
xbacklight -set 20
conky &
export DefaultIMModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &
/usr/lib/mozc/mozc-server &
xrdb -load ~/.Xresources
exec twm
