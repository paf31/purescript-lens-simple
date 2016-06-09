## Module Optic.Lens.Simple

This module defines a simple implementation of _lenses_, i.e. functional
getters and setters.

For an industrial-strength implementation of lenses, and other optics, see
`purescript-lens`.

#### `Lens`

``` purescript
newtype Lens a b
```

A lens which focusses from an outer structure of type `a` to an inner structure of type `b`.

##### Instances
``` purescript
Semigroupoid Lens
Category Lens
```

#### `lens`

``` purescript
lens :: forall a b. (a -> b) -> (a -> b -> a) -> Lens a b
```

Create a lens from a getter and a setter.

#### `get`

``` purescript
get :: forall a b. Lens a b -> a -> b
```

Use a lens to get a value inside a larger structure.

#### `set`

``` purescript
set :: forall a b. Lens a b -> b -> a -> a
```

Use a lens to set a value inside a larger structure.

#### `modify`

``` purescript
modify :: forall a b. Lens a b -> (b -> b) -> a -> a
```

Use a lens to modify a value inside a larger structure.

#### `(^.)`

``` purescript
infixl 2 view as ^.
```

#### `view`

``` purescript
view :: forall a b. a -> Lens a b -> b
```

An infix alias for `get`.

#### `fstL`

``` purescript
fstL :: forall a b. Lens (Tuple a b) a
```

A lens which accesses the first component of a `Tuple.

#### `sndL`

``` purescript
sndL :: forall a b. Lens (Tuple a b) b
```

A lens which accesses the second component of a `Tuple.


