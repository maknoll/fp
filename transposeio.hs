import System.IO
import Data.List
import Data.Function

transposeStr :: [String] -> [String]
transposeStr list = map (foldl (++) "") $ transpose $ map (\ x -> foldr (\e a -> [e] : a) [] $ x ++ (foldl (++) "" (take (foldr (\e a -> if length e > a then length e else a) 0 list - (length x)) $ repeat " "))) list


transposeIO :: FilePath -> FilePath -> IO ()
transposeIO source destination = do
  lines <- do {contents <- readFile source; return $ lines contents}
  writeFile destination $ unlines $ transposeStr lines

test = transposeIO "trans.txt" "trans2.txt"
