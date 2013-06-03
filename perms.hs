import Data.List

-- Bind/Sequence
perms' :: Eq a => [a] -> [[a]]
perms' [] = [[]]
perms' l = l >>= \h -> perms'' (delete h l) >>= \t -> [h : t]

-- do-Notation
perms'' :: Eq a => [a] -> [[a]]
perms'' [] = [[]]
perms'' l = do
  h <- l
  t <- perms'' $ delete h l
  [h : t]
