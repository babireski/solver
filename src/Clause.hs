module Clause where

import Data.List (nub)
import GHC.Exts.Heap (GenClosure(literals))

type Atom      = Integer
type Literal   = Integer
type Value     = Integer
type Clause    = [Literal]
type Clauses   = [Clause]
type Valuation = [(Atom, Value)]

complement :: Literal -> Literal
complement literal = -literal

polarity :: Literal -> Value
polarity literal = if literal < 0 then -1 else 1

atom :: Literal -> Atom
atom = abs

atoms :: Clauses -> [Atom]
atoms clauses = nub (concatMap (map atom) clauses)

literals :: Clauses -> [Literal]
literals = concat

remove :: Literal -> Clause -> Clause
remove literal [] = []
remove literal (x:xs) = if literal == x then remove literal xs else x : remove literal xs

(∈) :: Eq a => a -> [a] -> Bool
(∈) = elem

(∉) :: Eq a => a -> [a] -> Bool
(∉) = notElem
