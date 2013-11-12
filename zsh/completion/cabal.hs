#!/usr/bin/env runhaskell
-- LICENSE: MIT

import Data.Char (toLower)
import Data.List (intercalate, find, delete)
import Data.Maybe (fromJust, fromMaybe, maybeToList)
import Control.Monad (when)
import Control.Applicative

import qualified System.Process (readProcess)
import Control.Monad.Writer (execWriter, tell)

import Data.Maybe.HT (toMaybe)
import Data.String.HT (trim)
import Data.List.HT (chop, search, replace)
import Safe (tailSafe, headDef)

-- | Exec cabal with the arguments and returns the output.
-- This is the only interface to the world out of haskell.
cabal :: [String] -> IO String
cabal args = System.Process.readProcess "cabal" args []


-- | split with blank line
paragraphs :: String -> [String]
paragraphs = map unlines . chop null . lines

searchParagraph :: String -> String -> Maybe String
searchParagraph x = find (notNull . search x . firstLine) . paragraphs
    where
      notNull = not . null
      firstLine = head . lines

usageParagraph :: String -> String
usageParagraph = fromJust . searchParagraph "Usage:"

commandsParagraph :: String -> String
commandsParagraph = fromJust . searchParagraph "Commands:"

globalFlagsParagraph :: String -> String
globalFlagsParagraph = fromJust . searchParagraph "Global flags:"

commandFlagsParagraph :: String -> Maybe String
commandFlagsParagraph = searchParagraph "Flags for "


-- | (command, descr)
parseCommand :: String -> (String, String)
parseCommand str =
    let (x : ys) = words . trim $ str
    in (x, unwords ys)

parseCommands :: String -> [(String, String)]
parseCommands = map parseCommand . tail . lines

-- | (flags, descr, arg)
parseFlag :: String -> ([String], String, Maybe String)
parseFlag str =
    let (flgs', descr') = span ((== '-') . head) . words . trim $ str
        descr = unwords descr'
        f flg' =
            let (flg, arg) = break (`elem` ['[','=',']']) flg'
            in if '=' `elem` arg then (flg ++ "=", delete '=' arg) else (flg, arg)
        (flgs, marg'') = unzip . map f $ flgs'
        marg' = concat marg''
        marg = toMaybe (not . null $ marg') marg'
    in (flgs, descr, marg)

parseFlags :: String -> [([String], String, Maybe String)]
parseFlags str =
    let lns'' = tail . lines $ str
        lns' = (\ f -> foldl f [] lns'') $ \ acc ln -> case ln of
           -- leading 8 blanks: don't begin new option
           (' ':' ':' ':' ':' ':' ':' ':' ':_) -> (headDef [] acc ++ ln) : tailSafe acc
           _ -> ln : acc
        lns = reverse lns'
    in map parseFlag lns

getUsage :: Maybe String -> IO String
getUsage = (usageParagraph <$>) . cabal . ("help" :) . maybeToList

getCommands :: IO [(String, String)]
getCommands = parseCommands . commandsParagraph <$> cabal ["help"]

getGlobalFlags :: IO [([String], String, Maybe String)]
getGlobalFlags = parseFlags . globalFlagsParagraph <$> cabal ["help"]

getCommandFlags :: String -> IO [([String], String, Maybe String)]
getCommandFlags cmd = do
  str <- cabal ["help", cmd]
  return $ fromMaybe [] (parseFlags <$> commandFlagsParagraph str)


convFlag :: ([String], String, Maybe String) -> String
convFlag (flgs, descr, marg) = execWriter $ do
  tell $ case flgs of
    [x] -> '\'' : x
    xs -> '{' : intercalate "," xs ++ "}'"
  tell ('[' : (replace "'" "'\\''") descr ++ "]")
  tell $ case marg of
    Nothing -> []
    Just arg -> -- double colon means that the option is optional
        let (cln,arg') = if '[' `elem` arg
                         then ([':'], delete '[' . delete ']' $ arg)
                         else ([], arg)
        in ':' : cln ++ arg' ++ ':' : case arg' of
      "PATH" -> "_files"
      "DIR" -> "_files -/"
      _ -> []
  tell "'"

convCommand :: (String, String) -> String
convCommand (cmd, descr) = '\'' : cmd ++ "[" ++ descr ++ "]'"

convFlags :: [([String], String, Maybe String)] -> String
convFlags = unwords . map convFlag

convCommands :: [(String, String)] -> String
convCommands = unwords . map convCommand


newline :: IO ()
newline = putStrLn []

bracket :: IO a -> IO a
bracket f = putStrLn "{" >> f <* putStrLn "}"


-- | header
compdef_cabal :: IO ()
compdef_cabal = putStrLn "#compdef cabal"

__cabal_commands :: IO ()
__cabal_commands = do
  gcmds <- getCommands

  (putStr "__cabal_commands() " >>) . bracket $ do
     putStrLn ("_values commands " ++ convCommands gcmds)

-- | functions of commands
__cabal_COMMAND_s :: IO ()
__cabal_COMMAND_s = do
  gcmds <- getCommands

  (`mapM_` map fst gcmds) $ \ cmd -> do
     (putStr ("__cabal_" ++ cmd ++ "() ") >>) . bracket $ do
        -- packages
        cusg <- getUsage (Just cmd)
        let packages = if not . null . search "package" . map toLower $ cusg
               then ["'*: :__cabal_packages'"]
               else []
        -- flags
        cflgs <- getCommandFlags cmd
        when (not . null $ cflgs) $
           putStrLn . unwords $
              [ "_arguments"
              , convFlags cflgs
              ] ++ packages

-- | main function
_cabal :: IO ()
_cabal = do
  gcmds <- getCommands
  gflgs <- getGlobalFlags

  (putStr "_cabal() " >>) . bracket $ do
     putStrLn . unwords $
        [ "_arguments"
        , "-C" -- use "->hoge" syntax
        , convFlags gflgs
        , "'1: :__cabal_commands'"
        , "'*:: :->args'"
        ]

     mapM_ putStrLn
        [ "case $state in"
        , "  args )"
        , "    case $line[1] in"
        ]
     (`mapM_` (map fst gcmds)) $ \ cmd -> do
                  mapM_ putStrLn $
                    [ cmd ++ ")"
                    , "__cabal_" ++ cmd
                    , ";;"
                    ]
     mapM_ putStrLn
        [ "    esac"
        , "  ;;"
        , "esac"
        ]

__cabal_packages :: IO ()
__cabal_packages = mapM_ putStrLn
  [ "__cabal_packages() {"
  , "    case \"${line[-1]}\" in"
  , "        -* ) ;; # option"
  , "        ? | ?? )"
  , "            _message 'too short to complement'"
  , "            ;;"
  , "        ???* )"
  , "            packages=(`cabal list -v0 --simple-output \"${line[-1]}\" | tr \\  - `)"
  , "            if [ \"${#packages[@]}\" -ne 0 ] ; then"
  , "                _values packages \"${packages[@]}\""
  , "            else"
  , "                _message 'package not found'"
  , "            fi"
  , "            ;;"
  , "    esac"
  , "}"
  ]

comments :: IO ()
comments = mapM_ putStrLn . map (\ x -> (if not $ null x then ('#' :) . (' ' :) else id) x) $
  [ ""
  , "This zsh completion file is made by a haskell script."
  , "So, you should not edit this directly."
  , ""
  , "LICENSE: MIT"
  , ""
  , "But why did I make this through haskell?"
  , "I can't find any meaning excluding that made by haskell."
  , "We can make this with only sh & sed."
  , ""
  , ""
  ]


main :: IO ()
main = do
  compdef_cabal
  comments
  __cabal_commands
  __cabal_COMMAND_s
  __cabal_packages
  _cabal
