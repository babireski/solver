module Solver where

import Clause (Valuation, Clauses, Literal, complement, atom, polarity)
import Data.List (delete)

solve :: Clauses -> Valuation -> Maybe Valuation
solve clauses valuation =
    let simplified = simplify clauses in
    if null simplified then return valuation
    else
        if unsatisfiable simplified then Nothing
        else
            let literal = choose simplified in
            case solve ([literal] : simplified) ((atom literal, polarity literal) : valuation) of
                Nothing -> case solve ([complement literal] : simplified) ((atom literal, polarity (complement literal)) : valuation) of
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
