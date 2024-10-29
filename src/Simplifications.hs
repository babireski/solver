module Simplifications where

import Clause
import Data.List (intersect)

simplifications :: [(Clauses, Valuation) -> (Clauses, Valuation)]
simplifications = [unit, Simplifications.pure, pole]

apply :: [a -> a] -> a -> a
apply = foldr (.) id

unit :: (Clauses, Valuation) -> (Clauses, Valuation)
unit (clauses, valuation) =
    let units = filter ((== 1) . length) clauses in
        if null units then (clauses, valuation)
        else
            let literal = first units
                updated = filter (literal ∉) (map (remove (complement literal)) clauses)
                revaluation = (atom literal, polarity literal) : valuation
            in unit (updated, revaluation)

pure :: (Clauses, Valuation) -> (Clauses, Valuation)
pure (clauses, valuation) =
    let pures = filter (\literal -> complement literal ∉ literals clauses) (literals clauses) in
        if null pures then (clauses, valuation)
        else
            let updated = filter (\clause -> null $ intersect clause pures) clauses
                revaluation = valuation ++ map (\literal -> (atom literal, polarity literal)) pures
            in Simplifications.pure (updated, revaluation)

pole :: (Clauses, Valuation) -> (Clauses, Valuation)
pole (clauses, valuation) =
    let poles = filter (\clause -> any (\literal -> complement literal ∈ clause) clause) clauses
        updated = filter (∉ poles) clauses
    in (updated, valuation)

first :: Clauses -> Literal
first clauses = head (head clauses)