takeWhileIO :: (a -> Bool) -> IO a -> IO [a]
takeWhileIO pred oper = do
  input <- oper
  if pred input then
    do
      next <- takeWhileIO pred oper
      return $ input : next
  else
    return []

-- *Main Data.Char Data.String> takeWhileIO (\x -> odd $ read x) getLine
-- 1
-- 3
-- 5
-- 6
-- ["1","3","5"]
-- *Main Data.Char Data.String> takeWhileIO (\x -> (/=) 5 $ read x) getLine
-- 1
-- 2
-- 3
-- 4
-- 5
-- ["1","2","3","4"]
-- *Main Data.Char Data.String> 
