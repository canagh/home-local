import XMonad
import XMonad (defaultConfig)
-- import XMonad.Config.Gnome (gnomeConfig)


import XMonad.Layout.Gaps (GapMessage(ToggleGaps), Direction2D(U), gaps)
import XMonad.Layout.ResizableTile (MirrorResize(MirrorShrink, MirrorExpand), ResizableTall(ResizableTall))
import XMonad.Layout.MultiToggle (Toggle(Toggle), mkToggle1)
import XMonad.Layout.MultiToggle.Instances (StdTransformers(FULL))
import qualified XMonad.StackSet as W
import System.IO (hPutStrLn)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, ppOutput, ppVisible, wrap)
import XMonad.Actions.NoBorders (toggleBorder)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run(spawnPipe)

mapManageHook :: (ManageHook -> ManageHook) -> XConfig l -> XConfig l
mapManageHook f config = config { manageHook = f (manageHook config) }
addManageHook x y = mapManageHook (<+> y) x

mapLayoutHook :: (l Window -> l Window) -> XConfig l -> XConfig l
mapLayoutHook f config = config { layoutHook = f (layoutHook config) }
addLayoutHook x y = mapLayoutHook (<+> y) x

addXMobar :: XConfig l -> IO (XConfig l)
addXMobar x = do
    proc <- spawnPipe "xmobar"
    return x
        { logHook = logHook x <+> dynamicLogWithPP defaultPP
            { ppOutput = hPutStrLn proc
            , ppVisible = wrap "(" ")"
            }
        }

configureBorder :: XConfig l -> XConfig l
configureBorder x = x
    { borderWidth = 2
    , normalBorderColor = "#99ccff"
    , focusedBorderColor = "#0033dd"
    }

-- configureLayoutHook :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
--                     -> XConfig (Choose Tall (Choose (Mirror Tall) Full))
-- configureLayoutHook =
--     flip addLayoutHook
--         (let tall = ResizableTall 1 (3/100) (1/2) []
--             in smartBorders $ mkToggle1 FULL $ gaps [(U, 24)] $ tall ||| Mirror tall)

main :: IO ()
main = do
    let modm = mod3Mask
    let config = defaultConfig
            { modMask = modm
            , terminal = "gnome-terminal"
            }
            `additionalKeys`
                [ ((modm, xK_u), runOrRaise "firefox" (className =? "Firefox"))
                , ((modm, xK_i), runOrRaise "gnome-terminal" (className =? "Gnome-terminal"))
                , ((modm, xK_o), runOrRaise "opera" (className =? "Opera"))
                , ((modm, xK_y), runOrRaise "mikutter" (className =? "Mikutter.rb"))
                , ((modm, xK_f), sendMessage (Toggle FULL))
                , ((modm, xK_g), sendMessage ToggleGaps)
                , ((modm, xK_b), withFocused toggleBorder)
                , ((modm, xK_j), sendMessage MirrorShrink)
                , ((modm, xK_k), sendMessage MirrorExpand)
                , ((modm, xK_period), windows W.focusDown)
                , ((modm, xK_comma), windows W.focusUp)
                , ((modm .|. shiftMask, xK_period), windows W.swapDown)
                , ((modm .|. shiftMask, xK_comma), windows W.swapUp)
                -- , ((modm .|. shiftMask, xK_q), spawn "gnome-session-quit")
                ]
    xmonad =<< addXMobar (configureBorder $ config)
