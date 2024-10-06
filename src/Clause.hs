module Clause where

import Data.List (nub)

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
