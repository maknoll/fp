import Data.Functor
import Control.Applicative
import Control.Monad

composeMaybe :: (a -> Maybe b) -> (b -> Maybe c) ->  (a -> Maybe c)
composeMaybe f = \g -> (>>= g).f
