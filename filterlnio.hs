import System.IO
import Data.List

filterLn :: (String -> Bool) -> [String] -> [String]
filterLn p ls = reverse $ match p ls [] 1 where
    match p []    x y = (("#: " ++ (show $ length x) ++ " %: " ++ (show ((fromIntegral $ length x) / (fromIntegral y)))) : ("" : x))
    match p [s]   x y = if p s then match p [] (("Z " ++ (show y) ++ ": " ++ s) : x) y else match p [] x y
    match p (s:ls) x y = if p s then match p ls (("Z " ++ (show y) ++ ": " ++ s) : x) (y + 1) else match p ls x (y + 1)

filterLnIO :: (String -> Bool) -> FilePath -> FilePath -> IO ()
filterLnIO f source destination = do
  lines <- do {contents <- readFile source; return $ lines contents}
  writeFile destination $ unlines $ filterLn f lines

test = filterLnIO (isInfixOf "e") "test.txt" "test2.txt"
