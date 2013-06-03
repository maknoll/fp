data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Eq, Ord, Show, Read)
type Table a = [a]

data State a b = State (Table a -> (Table a, b))

instance Monad (State a) where
  return x = State (\tab -> (tab,x))
  (State st) >>= f = State (\tab -> let (newTab,y)    = st tab
                                        (State trans) = f y
                                    in  trans newTab)

lookup' elem tableG
    = look elem tableG 0
      where
      look elem table pos 
	  = case table of
             [] -> error ("from lookup': table " ++ show tableG ++ " does not contain elem " ++ show elem)
	     x:xs -> if x == elem then pos else look elem xs (pos + 1)


numberNode x = State (nNode x)

nNode x table
      | elem x table = (table     , lookup' x table)
      | otherwise    = (table++[x], length table)

extract (State st) = snd (st [])

numTree :: (Show a, Eq a) => Tree a -> Tree Int
numTree = extract . numberTree



-- Pre-order-Traversierung (vgl. Vorlesung)
numberTree Nil            = return Nil
numberTree (Node x t1 t2) = do num <- numberNode x
                               nt1 <- numberTree t1
                               nt2 <- numberTree t2
                               return (Node num nt1 nt2)

numberTree' Nil            = return Nil
numberTree' (Node x t1 t2) = numberNode x >>= \num ->
                             numberTree' t1 >>= \nt1 ->
                             numberTree' t2 >>= \nt2 ->
                             return (Node num nt1 nt2)

-- In-order-Traversierung
numberTreeInO :: (Eq a, Show a) => Tree a -> State a (Tree Int)
numberTreeInO Nil = return Nil
numberTreeInO (Node x t1 t2) = do nt1 <- numberTree t1
                                  num <- numberNode x
                                  nt2 <- numberTree t2
                                  return $ Node num nt1 nt2

numTreeInO :: (Show a, Eq a) => Tree a -> Tree Int
numTreeInO = extract . numberTreeInO

-- Post-order-Traversierung
numberTreePostO :: (Eq a, Show a) => Tree a -> State a (Tree Int)
numberTreePostO Nil = return Nil
numberTreePostO (Node x t1 t2) = do nt1 <- numberTree t1
                                    nt2 <- numberTree t2
                                    num <- numberNode x
                                    return (Node num nt1 nt2)

numTreePostO :: (Show a, Eq a) => Tree a -> Tree Int
numTreePostO = extract . numberTreePostO


--------------------------------------------------------------------------------

update val table = if elem val table then table else table ++ [val]

-- Pre-order-Traversierung
-- Hinweis: auf VL-Folien wurde numTree'' mittels case-Konstrukt beschrieben
-- die nachfolgende auf Pattern-Matching basierende Version ist zu dieser aequivalent
numTree'' tree = newTree where
    (newTree, table) = traverseConvert (tree,[]) 
    traverseConvert (Nil, table) = (Nil, table)
    traverseConvert ((Node val left right), table) = ((Node (lookup' val rightTable) newLeft newRight), rightTable) where
        (newLeft,  leftTable)  = traverseConvert (left, (update val table))
        (newRight, rightTable) = traverseConvert (right, leftTable)

-- In-order-Traversierung
numTreeInO'' :: (Show a, Eq a) => Tree a -> Tree Int
numTreeInO'' = error "not implemented"

-- Post-order-Traversierung
numTreePostO'' :: (Show a, Eq a) => Tree a -> Tree Int
numTreePostO'' = error "not implemented"


tree1 = Node "Moon"
             (Node "Ahmet" Nil Nil)
             (Node "Dweezil"
                   (Node "Ahmet" Nil Nil)
                   (Node "Moon" Nil Nil))
