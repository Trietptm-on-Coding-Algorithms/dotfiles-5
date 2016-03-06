xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 0,0,0,0,0,0,0
xbacklight -set 20
conky &
export DefaultIMModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &
/usr/lib/mozc/mozc-server &
xrdb -load ~/.Xresources
xv -root -max  -quit ~/Pictures/back.jpg
#exec twm
#LD_PRELOAD=/lib/x86_64-linux-gnu/libSegFault.so exec ~/prog/twm/twm 2>>~/twm_err
LD_PRELOAD=/lib/x86_64-linux-gnu/libSegFault.so exec ~/prog/twm/bin/twm 2>>~/twm_err
