{-# LANGUAGE FlexibleContexts #-}
import XMonad

import Data.Monoid (Monoid)
import System.IO (hPutStrLn)
import Control.Applicative ((<$>))

import Safe (initSafe)
import Data.Tuple.HT (mapFst)

import XMonad.Config.Desktop (desktopConfig)
import XMonad.Actions.NoBorders (toggleBorder)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.CycleWS (nextWS, prevWS, shiftToNext, shiftToPrev)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, ppOutput, ppVisible, wrap)
import XMonad.Hooks.ManageDocks (manageDocks, AvoidStruts, ToggleStruts(ToggleStruts))
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.NoBorders (smartBorders, SmartBorder)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run(spawnPipe, runProcessWithInput)

mapManageHook :: (ManageHook -> ManageHook) -> XConfig l -> XConfig l
mapManageHook f conf = conf { manageHook = f (manageHook conf) }
addManageHook :: XConfig l -> ManageHook -> XConfig l
addManageHook x y = mapManageHook (<+> y) x

mapLayoutHook :: (l0 Window -> l1 Window) -> XConfig l0 -> XConfig l1
mapLayoutHook f conf = conf { layoutHook = f (layoutHook conf) }
addLayoutHook :: Monoid (l Window) => XConfig l -> l Window -> XConfig l
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

configureLayoutHook
    :: XConfig (ModifiedLayout AvoidStruts (Choose Tall (Choose (Mirror Tall) Full)))
    -> XConfig (ModifiedLayout SmartBorder
               (ModifiedLayout AvoidStruts (Choose Tall (Choose (Mirror Tall) Full))))
configureLayoutHook = mapLayoutHook smartBorders

configureManageHook :: XConfig l -> XConfig l
configureManageHook = flip addManageHook manageDocks

additionalKeysMod :: XConfig l -> [(KeySym, X ())] -> XConfig l
additionalKeysMod x = additionalKeys x . map (mapFst ((,) $ modMask x))

additionalKeysModShift :: XConfig l -> [(KeySym, X ())] -> XConfig l
additionalKeysModShift x = additionalKeys x . map (mapFst ((,) (modMask x .|. shiftMask)))

configureKeys :: XConfig l -> XConfig l
configureKeys =
    flip additionalKeysMod
        [ (xK_u, runOrRaise "firefox"  (className =? "Firefox"))
        , (xK_o, runOrRaise "chromium-browser" (className =? "Chromium-browser"))
        -- , (xK_o, runOrRaise "opera" (className =? "Opera"))
        , (xK_y, runOrRaise "mikutter" (className =? "Mikutter.rb"))
        , (xK_g, sendMessage ToggleStruts) -- Mod-b: toggle XFCE panel
        , (xK_b, withFocused toggleBorder)
        , (xK_h, prevWS) -- override
        , (xK_l, nextWS) -- override
        ]
    . flip additionalKeysModShift
        [ (xK_h, shiftToPrev)
        , (xK_l, shiftToNext)
        , (xK_comma,  sendMessage Shrink) -- escape
        , (xK_period, sendMessage Expand) -- escape
        ]


configureTerminal :: XConfig l -> IO (XConfig l)
configureTerminal x = do
    termname  <- initSafe <$> runProcessWithInput "term" [     "--name"] ""
    termclass <- initSafe <$> runProcessWithInput "term" ["--classname"] ""
    return $ x { terminal = termname }
        `additionalKeysMod` [(xK_i, runOrRaise termname (className =? termclass))]

main :: IO ()
main = (xmonad =<<)
    . configureTerminal
    . configureManageHook
    . configureLayoutHook
    . configureBorder
    . configureKeys
    $ desktopConfig
    { modMask = mod4Mask }
