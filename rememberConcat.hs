newtype State s a = State {runState :: s -> (a,s)}

instance Monad (State s) where  
    return x = State (\s -> (x,s))
    (State h) >>= f = State (\s -> let (a, newState) = h s
                                       (State g)     = f a  
                                   in  g newState)


rememberConcat :: String -> [Int] -> State String [Int]
rememberConcat s l = State $ \ xs -> (l ++ [length s], xs ++ s)

extractRC :: State String [Int] -> ([Int], String)
extractRC (State s) = s []

undoConcat :: ([Int],String) -> [String]
undoConcat ([], _) = []
undoConcat (h:t, s) = take h s : undoConcat (t, drop h s)
