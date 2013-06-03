import Sheep
import Data.Maybe
import Control.Monad

parents :: Int -> Sheep -> Maybe Sheep
parents 0 sheep = Just sheep
parents n sheep = case maybe Nothing (parents $ n - 1) $ mother sheep of
  Just mom -> Just mom
  Nothing -> maybe Nothing (parents $ n - 1) $ father sheep

parents' :: Int -> Sheep -> [Sheep]
parents' 0 sheep = [sheep]
parents' n sheep = (maybe [] (parents' $ n - 1) $ mother sheep) ++ (maybe [] (parents' $ n - 1) $ father sheep)
