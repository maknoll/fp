map' :: (a -> b) -> [a] -> [b]
map' f l = [f e | e <- l]

concat' :: [[a]] -> [a]
concat' ll = [e | l <- ll, e <- l]

-- Die Implementierungen sind nahezu identisch. List Comprehnsiom scheint nur ein Alias für die genannten Monaden zu sein.
