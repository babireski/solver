module Main where

import Clause (Valuation, Clauses, atoms)
import Data.List (sort)
import Parser (parse)
import Solver (solve)
import System.Environment (getArgs)

main :: IO ()
main = do
    arguments <- getArgs
    if length arguments /= 1 then error "Please provide exactly one argument."
    else do
        let filepath = head arguments
        clauses <- parse filepath
        write filepath clauses

complete :: Clauses -> Valuation -> Valuation
complete clauses valuation =
    let biggest = maximum (atoms clauses)
        missing = [atom | atom <- [1..biggest], atom `notElem` map fst valuation]
    in valuation ++ [(atom, 1) | atom <- missing]

result :: Valuation -> String
result valuation = helper (sort valuation) where
    helper []          = []
    helper [(a, v)]    = show (v * a) ++ "\n"
    helper ((a, v):r)  = show (v * a) ++ " " ++ result r

write :: String -> Clauses -> IO ()
write filepath clauses = let answer = solve clauses [] in case answer of
    Nothing        -> writeFile (filepath ++ ".res") "UNSAT\n"
    Just valuation -> writeFile (filepath ++ ".res") $ "SAT\n" ++ result (complete clauses valuation)
