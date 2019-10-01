import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doRectFloat, doCenterFloat)
-- import XMonad.StackSet.RationalRect
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import System.IO

----------------------
-- my configuration --
----------------------
myTerminal           = "termite"
myModMask            = mod4Mask -- Win key or Super_L
myBorderWidth        = 1
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#FF0000"

-------------
-- hotkeys --
-------------
myKeys =
        [
        ((mod4Mask,               xK_d),     spawn "rofi -show run"),
        ((mod4Mask,               xK_w),     spawn "brave"),
        ((mod4Mask .|. shiftMask, xK_z),     spawn "xscreensaver-command -lock"),
        ((controlMask,            xK_Print), spawn "sleep 0.2; scrot -s"),         -- copy the current window
        ((0,                      xK_Print), spawn "scrot")                        -- copy the current screen
        ]

-------------------------
-- startup aplications --
-------------------------
myStartupHook        = do
          spawnOnce "xrandr -s 1360x768 &"                                -- resolution
          spawnOnce "nitrogen --restore &"                                -- wallpaper
          spawnOnce "compton --config /home/leandro/.config/compton.conf" -- compositor

----------------------
-- floating windows --
----------------------
myManageHook         = composeAll
                       [
                       className =? "Gimp" --> doFloat,
                       className =? "Nemo" --> doFloat
                       -- className =? "Nitrogen" --> doRectFloat (RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2))
                       ]
------------------------
-- main configuration --
------------------------ 
main = do

    xmproc <- spawnPipe "/usr/bin/xmobar /home/leandro/.xmobarrc"

    xmonad $ defaultConfig
        {
        terminal           = myTerminal,
        modMask            = myModMask,
        borderWidth        = myBorderWidth,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        startupHook        = myStartupHook,

        manageHook    = manageDocks <+>
                        myManageHook <+>          -- include myManageHook
                        manageHook defaultConfig,
        layoutHook    = avoidStruts  $  layoutHook defaultConfig,
        logHook       = dynamicLogWithPP xmobarPP
                {
                ppOutput     = hPutStrLn xmproc,
                ppTitle      = xmobarColor "green" "" . shorten 50
                }
        }

        `additionalKeys` myKeys
