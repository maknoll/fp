hd :: [a] -> [a]
hd []     =  []
hd (x:xs) =  [x]

tl:: [a] -> [[a]]
tl []     = []
tl (x:xs) = [xs]

-- Bind/Sequence
transpose' :: [[a]] -> [[a]]
transpose' []       =  []
transpose' ([]:ls)  =  transpose' ls
transpose' ll       =  foldr (++) [] (ll >>= \l -> return $ hd l) : (transpose''.foldr (++) []) (ll >>= \l -> return $ tl l)

-- do-Notation
transpose'' :: [[a]] -> [[a]]
transpose'' []       =  []
transpose'' ([]:ls)  =  transpose'' ls
transpose'' ll       =  foldr (++) [] (do
  l <- ll
  return (hd l)) : (transpose''.foldr (++) []) (do
    l <- ll
    return $ tl l)
