newtype State s a = State {runState :: s -> (a,s)}

instance Monad (State s) where  
    return x = State $ \s -> (x,s)  
    (State h) >>= f = State $ \s -> let (a, newState) = h s  
                                        (State g) = f a  
                                    in  g newState 

countConcat :: String -> Int -> State String Int
countConcat s i = State $ \ xs -> (i + 1, xs ++ s)

extractCC :: State String Int -> (Int, String)
extractCC (State s) = s []
