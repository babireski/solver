module Solver where

import Clause (Valuation, Clauses, Literal, complement, atom)
import Data.List (delete)

solve :: Clauses -> Valuation -> Maybe Valuation
solve clauses valuation =
    let clauses = simplify clauses in
    if null clauses then return valuation
    else
        if unsatisfiable clauses then Nothing
        else
            let literal = choose clauses in
            case solve ([literal] : clauses) ((atom literal, 1) : valuation) of
                Nothing -> case solve ([complement literal] : clauses) ((atom literal, -1) : valuation) of
                    Nothing -> Nothing
                    result  -> result
                result  -> result

unsatisfiable :: Clauses -> Bool
unsatisfiable = elem []

simplify :: Clauses -> Clauses
simplify clauses =
    let units = filter ((== 1) . length) clauses in
        if null units then clauses
        else
            let literal = head (head units)
                updated = filter (notElem literal) (map (delete (complement literal)) clauses)
            in simplify updated

choose :: Clauses -> Literal
choose clauses = head (head clauses)
