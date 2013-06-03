accumulateIO :: [IO a] -> IO [a]
accumulateIO [] = do
  return []
accumulateIO (h:t) = do
  input <- h
  next <- accumulateIO t
  return $ input : next

sequenceIO :: [IO a] -> IO ()
sequenceIO [] = do
  return ()
sequenceIO (h:t) = do
  result <- h
  sequenceIO t

seqList :: [a -> IO a] -> a -> IO a
seqList [] init = do
  return init
seqList (h:t) init = do
  result <- h init
  seqList t result

-- *Main> accumulateIO [getLine, getLine, getLine]
-- Hallo
-- Welt
-- !
-- ["Hallo","Welt","!"]
--
-- *Main> sequenceIO [print "Alle",print "meine",print "Entchen"]
-- "Alle"
-- "meine"
-- "Entchen"
--
-- *Main> seqList [\x -> return $ x ++ "Meine", \x -> return $ x ++ "Entchen"] "Alle"
-- "AlleMeineEntchen"
