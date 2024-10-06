module Parser where

import Clause (Clauses, Clause)

parse :: String -> IO Clauses
parse filepath = do
    contents <- readFile filepath
    return $ filter (/= []) (map helper (lines contents))

helper :: String -> Clause
helper line
    | null line        = []
    | 'c' == head line = []
    | 'p' == head line = []
    | otherwise        = init $ map read (words line)
