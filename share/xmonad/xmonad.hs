import Control.Monad (liftM2, void)
import Control.Applicative ((<$>))
import Control.Monad.IO.Class (liftIO)

import System.Process (rawSystem)

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Config.Gnome (gnomeConfig)

import XMonad.Actions.NoBorders (toggleBorder)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run(spawnPipe)

configKeys :: XConfig l -> XConfig l
configKeys x =
    let modm = mod3Mask in x { modMask = modm }
    `additionalKeys`
    [ ((modm .|. shiftMask, xK_q), spawn "gnome-session-quit")
    , ((modm,  xK_g ), withFocused toggleBorder)
    ]

configBorder :: XConfig l -> XConfig l
configBorder x = x
    { borderWidth = 2
    , normalBorderColor = "#99ccff"
    , focusedBorderColor = "#0033dd"
    }

configApps :: XConfig l -> XConfig l
configApps x =
    let modm = modMask x in
    let viewShift = doF . liftM2 (.) W.view W.shift in x
    { terminal = "urxvt"
    , manageHook = manageHook x <+> composeAll
        [ className =? "Firefox" --> (viewShift $ last            $ workspaces x)
        -- , className =? "Emacs23" --> (viewShift $ (!! 1)           $ workspaces x)
        , className =? "V2C"     --> (viewShift $ (!! 1) $ reverse $ workspaces x)
        ]
    }
    `additionalKeys`
    -- [ ((modm, xK_y), runOrRaise "v2c"     (className =? "V2C"))
    [ ((modm, xK_y), runOrRaise "jd"     (className =? "Jd"))
    , ((modm, xK_u), runOrRaise "firefox" (className =? "Firefox"))
    -- , ((modm, xK_i), runOrRaise "gnome-terminal" (className =? "Gnome-terminal"))
    , ((modm, xK_i), runOrRaise "urxvt"   (className =? "URxvt"))
    , ((modm, xK_o), runOrRaise "mikutter" (className =? "Mikutter.rb"))
    -- , ((modm, xK_o), runOrRaise "emacsclient-x" (className =? "Emacs23"))
    ]

configHooks :: XConfig l -> XConfig l
configHooks x = x
    { manageHook = manageHook x <+> composeAll
                   [ className =? "Gimp"    --> doFloat

                   -- I can't avoid floatizing of main-window. So commented-out.
                   -- floatize firefox popup-windows
                   -- , (className =? "Firefox"
                   --   <&&> (not <$> className =? "Navigator")) --> doFloat
                   ]
    }



baseConfig = gnomeConfig

xmonadConfig = (configHooks . configApps . configBorder . configKeys) $ baseConfig

main :: IO ()
main = xmonad xmonadConfig
