import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig

import Graphics.X11.ExtraTypes.XF86
import Data.Ratio ((%))

main :: IO ()
main = xmonad $ defaultConfig
        { manageHook  = manageDocks <+> manageHook'
        , logHook     = logHook'
        , layoutHook  = layoutHook'
        , startupHook = setWMName "LG3D" -- For Swing
        , normalBorderColor  = normalBorderColor'
        , focusedBorderColor = focusedBorderColor'
        , modMask     = mod4Mask         -- Mod as the Windows key
        , terminal    = "xterm"
        } `additionalKeys` keys'

manageHook' :: ManageHook
manageHook' = manageHook defaultConfig

logHook' :: X ()
logHook' = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.8

layoutHook' = avoidStruts $ smartBorders $ tiled ||| Mirror tiled ||| Full
    where tiled   = Tall nmaster delta ratio
          nmaster = 1     -- The default number of windows in the master pane
          ratio   = 2%3   -- Default proportion of screen occupied by master pane
          delta   = 5%100 -- Percent of screen to increment by when resizing panes

keys' :: [((KeyMask, KeySym), X ())]
keys' =
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock'")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/Pictures")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures'")
    , ((0, xF86XK_MonBrightnessDown),  spawn "xbacklight -20")
    , ((0, xF86XK_MonBrightnessUp),  spawn "xbacklight +20")
    , ((0, xF86XK_AudioMute),        spawn "amixer set Master toggle && amixer set Headphone toggle && amixer set Speaker toggle")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2-")
    ]

normalBorderColor' :: String
normalBorderColor' = "gray"

focusedBorderColor' :: String
focusedBorderColor' = "purple"
