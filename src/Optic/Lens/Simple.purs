-- | This module defines a simple implementation of _lenses_, i.e. functional
-- | getters and setters.
-- |
-- | For an industrial-strength implementation of lenses, and other optics, see
-- | `purescript-lens`.

module Optic.Lens.Simple
  ( Lens()
  , lens
  , get
  , view
  , set
  , modify
  , fstL
  , sndL
  , (^.)
  ) where

import Prelude

import Data.Tuple (Tuple(..), fst, snd)

-- | A lens which focusses from an outer structure of type `a` to an inner structure of type `b`.
newtype Lens a b = Lens (a -> Tuple b (b -> a))

-- | Run a lens, providing a structure. The result will contain the inner structure and an
-- | function to modify it.
runLens :: forall a b. Lens a b -> a -> Tuple b (b -> a)
runLens (Lens l) = l

instance semigroupoidLens :: Semigroupoid Lens where
  compose f g = Lens \a ->
    case runLens g a of
      Tuple b ub -> case runLens f b of
        Tuple c uc -> Tuple c (ub <<< uc)

instance categoryLens :: Category Lens where
  id = Lens \a -> Tuple a id

-- | Create a lens from a getter and a setter.
lens :: forall a b. (a -> b) -> (a -> b -> a) -> Lens a b
lens getter setter = Lens \a -> Tuple (getter a) (setter a)

-- | Use a lens to get a value inside a larger structure.
get :: forall a b. Lens a b -> a -> b
get l a = fst (runLens l a)

-- | Use a lens to set a value inside a larger structure.
set :: forall a b. Lens a b -> b -> a -> a
set l b a = snd (runLens l a) b

-- | Use a lens to modify a value inside a larger structure.
modify :: forall a b. Lens a b -> (b -> b) -> a -> a
modify l f a = set l (f (get l a)) a

infixl 2 view as ^.

-- | An infix alias for `get`.
view :: forall a b. a -> Lens a b -> b
view = flip get

-- | A lens which accesses the first component of a `Tuple.
fstL :: forall a b. Lens (Tuple a b) a
fstL = lens fst \(Tuple _ b) a -> Tuple a b

-- | A lens which accesses the second component of a `Tuple.
sndL :: forall a b. Lens (Tuple a b) b
sndL = lens snd \(Tuple a _) b -> Tuple a b
