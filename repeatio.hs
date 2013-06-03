repeatIO :: IO Bool -> IO () -> IO ()
repeatIO test oper = do
  input <- test
  oper
  if input then
    do
      next <- repeatIO test oper
      return next
  else
    return ()

password =  do
  input <- getLine
  return $ input /= "geheim"

main = repeatIO password $ print "Password?"
