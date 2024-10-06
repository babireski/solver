module Clause where

import Data.List (nub)

type Atom      = Integer
type Literal   = Integer
type Clause    = [Literal]
type Clauses   = [Clause]
type Valuation = [(Atom, Integer)]

complement :: Literal -> Literal
complement literal = -literal

atom :: Literal -> Atom
atom = abs

atoms :: Clauses -> [Atom]
atoms clauses = nub (concatMap (map atom) clauses)
