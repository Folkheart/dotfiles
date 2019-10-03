import XMonad

import XMonad.Hooks.DynamicLog                    -- starusbar
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doCenterFloat)

-- import XMonad.Layout.NoBorders

import XMonad.Util.EZConfig(additionalKeys)       -- key bindings
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce                      -- startup applications

import System.IO

----------------------
-- my configuration --
----------------------
myTerminal           = "st"
myModMask            = mod4Mask -- Win key or Super_L
myBorderWidth        = 1
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#FF0000"

------------------
-- key bindings --
------------------
myKeys =
        [ ((mod4Mask,               xK_d),     spawn "rofi -show run")
        , ((mod4Mask,               xK_w),     spawn "firefox")
        , ((mod4Mask .|. shiftMask, xK_z),     spawn "xscreensaver-command -lock")
        -- print screen
        , ((controlMask,            xK_Print), spawn "sleep 0.2; scrot -s")         -- copy current window
        , ((0,                      xK_Print), spawn "scrot")                       -- copy current screen
        -- volume control
        , ((mod4Mask,               xK_u),     spawn "amixer set Master toggle")    -- mute audio toggle
        , ((mod4Mask,               xK_i),     spawn "amixer -q sset Master 5%-")   -- volume down
        , ((mod4Mask,               xK_o),     spawn "amixer -q sset Master 5%+")   -- volume up
        ]

-------------------------
-- startup aplications --
-------------------------
myStartupHook = do
        spawnOnce "xrandr -s 1360x768 &"                                -- resolution
        spawnOnce "nitrogen --restore &"                                -- wallpaper
        spawnOnce "compton --config /home/leandro/.config/compton.conf" -- compositor

----------------------
-- floating windows --
----------------------
myManageHook = composeAll
        [ className =? "Gimp"      --> doFloat
        , className =? "Nemo"      --> doFloat
        , className =? "Nitrogen"  --> doCenterFloat
        ]

------------------------
-- main configuration --
------------------------ 
main = do

    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/.xmobarrc"  -- run xmobar with .xmobarrc

    xmonad $ defaultConfig
        { terminal           = myTerminal
        , modMask            = myModMask
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , startupHook        = myStartupHook

        , manageHook  = manageDocks
                        <+> myManageHook              -- include myManageHook
                        <+> manageHook defaultConfig

        , layoutHook  = avoidStruts
                        $ layoutHook defaultConfig

        , logHook     = dynamicLogWithPP xmobarPP
                        { ppOutput     = hPutStrLn xmproc
                        , ppTitle      = xmobarColor "green" "" . shorten 50
                        }
        }

        `additionalKeys` myKeys
