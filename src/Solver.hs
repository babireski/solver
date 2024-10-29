module Solver where

import Clause (Valuation, Clauses, Literal, complement, atom, polarity, remove, (∉), literals)
import Data.List (delete, group, sort, maximumBy)
import Simplifications

solve :: Clauses -> Valuation -> Maybe Valuation
solve clauses valuation =
    let (simplified, revaluation) = simplify clauses valuation in
    if null simplified 
        then return revaluation
        else if unsatisfiable simplified 
            then Nothing
            else
                let literal = choose simplified in
                case solve ([literal] : simplified) revaluation of
                    Nothing -> solve ([complement literal] : simplified) revaluation
                    result  -> result

unsatisfiable :: Clauses -> Bool
unsatisfiable = any null

simplify :: Clauses -> Valuation -> (Clauses, Valuation)
simplify clauses valuation = Simplifications.apply simplifications (clauses, valuation)

choose :: Clauses -> Literal
choose clauses = 
    let smallest = minimum (map length clauses)
        filtered = filter (\clause -> length clause == smallest) clauses
    in snd $ maximum [(length grouping, head grouping) | grouping <- group $ sort $ literals clauses]