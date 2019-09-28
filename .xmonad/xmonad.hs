import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTerminal           = "termite"
myModMask            = mod4Mask -- Win key or Super_L
myBorderWidth        = 1
-- myNormalBorderColor  =
-- myFocusedBorderColor =

myManageHook         = composeAll      -- floating programs
                       [
                       className =? "Gimp" --> doFloat,
                       className =? "Nemo" --> doFloat
                       ]
 
main = do

    xmproc <- spawnPipe "/usr/bin/xmobar /home/leandro/.xmobarrc"

    xmonad $ defaultConfig
        {
        terminal           = myTerminal,
        modMask            = myModMask,
        borderWidth        = myBorderWidth,
        -- normalBorderColor  = myNormalBorderColor,
        -- focusedBorderColor = myFocusedBorderColor,

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

        `additionalKeys`
        [
        ((mod4Mask,               xK_d),     spawn "rofi -show run"),
        ((mod4Mask,               xK_w),     spawn "brave"),
        ((mod4Mask .|. shiftMask, xK_z),     spawn "xscreensaver-command -lock"),
        ((controlMask,            xK_Print), spawn "sleep 0.2; scrot -s"),         -- copy the current window
        ((0,                      xK_Print), spawn "scrot")                        -- copy the current screen
        ]
