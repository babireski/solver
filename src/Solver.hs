module Solver where

import Clause (Valuation, Clauses, Literal, complement, atom, polarity, remove, (∉))
import Data.List (delete)
import Debug.Trace (trace)

solve :: Clauses -> Valuation -> Maybe Valuation
solve clauses valuation =
    let (simplified, revaluation) = simplify clauses valuation in
    -- trace (show simplified <> " " <> show revaluation) (
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
simplify clauses valuation =
    let units = filter ((== 1) . length) clauses in
        if null units then (clauses, valuation)
        else
            let literal = choose units
                updated = filter (literal ∉) (map (remove (complement literal)) clauses)
            in simplify updated ((atom literal, polarity literal) : valuation)

choose :: Clauses -> Literal
choose clauses = head (head clauses)
