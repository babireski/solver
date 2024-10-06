module Parser where

import Clause (Clauses, Clause)

parse :: String -> IO Clauses
parse filepath = do
    contents <- readFile filepath
    let clauses = map helper (lines contents)
    case sequence clauses of
        Nothing      -> error $ "Unable to parse file.\n" ++ show clauses
        Just clauses -> return clauses

helper :: String -> Maybe Clause
helper line
    | null line        = Nothing
    | 'c' == head line = Nothing
    | 'p' == head line = Nothing
    | otherwise        = Just $ map read (words line) >>= filter (/= 0)
