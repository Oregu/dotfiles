import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86

main :: IO ()
main = xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , logHook    = fadeHook
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , modMask    = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys` keys'

fadeHook :: X ()
fadeHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.8

keys' :: [((KeyMask, KeySym), X ())]
keys' =
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock'")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/Pictures")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures'")
    , ((0, xF86XK_MonBrightnessUp),  spawn "xbacklight +20")
    , ((0, xF86XK_AudioMute),        spawn "amixer set Master toggle && amixer set Headphone toggle")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2-")
    ]
