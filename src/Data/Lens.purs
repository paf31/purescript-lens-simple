module Data.Lens where

newtype Lens a b = Lens (a -> { focus :: b, update :: b -> a })

runLens :: forall a b. Lens a b -> a -> { focus :: b, update :: b -> a }
runLens (Lens l) = l

instance semigroupoidLens :: Semigroupoid Lens where
  (<<<) f g = Lens \a -> 
    let o1 = runLens g a
        o2 = runLens f o1.focus
    in { focus: o2.focus
       , update: \c -> o1.update (o2.update c)
       }

instance categoryLens :: Category Lens where
  id = Lens \a -> { focus: a, update: \b -> b }

lens :: forall a b. (a -> b) -> (a -> b -> a) -> Lens a b
lens get set = Lens \a -> { focus: get a, update: \b -> set a b }

get :: forall a b. Lens a b -> a -> b
get lens a = (runLens lens a).focus

set :: forall a b. Lens a b -> b -> a -> a
set lens b a = (runLens lens a).update b

modify :: forall a b. Lens a b -> (b -> b) -> a -> a
modify lens f a = set lens (f (get lens a)) a

infixl 9 ^.

(^.) :: forall a b. a -> Lens a b -> b
(^.) = flip get

