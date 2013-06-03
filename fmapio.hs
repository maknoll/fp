fmapIO :: (a -> b) -> IO a -> IO b
fmapIO lambda input = do
  value <- input
  return $ lambda value

fmapIO' :: (a -> b) -> IO a -> IO b
fmapIO' lambda input = input >>= (\value -> return $ lambda value)

-- *Main> fmapIO reverse getLine
-- Hallo Welt!
-- "!tleW ollaH"
-- *Main> fmapIO' reverse getLine
-- Hello World!
-- "!dlroW olleH"
-- *Main> 
