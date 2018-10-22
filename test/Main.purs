module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Optic.Lens.Simple (Lens, lens, set, (^.))

type Person = { first :: String, last :: String, address :: Address }

type Address = { street :: String, city :: String, state :: String }

first :: Lens Person String
first = lens _.first (_ { first = _ })

last :: Lens Person String
last = lens _.last (_ { last = _ })

address :: Lens Person Address
address = lens _.address (_ { address = _ })

street :: Lens Address String
street = lens _.street (_ { street = _ })

city :: Lens Address String
city = lens _.city (_ { city = _ })

state :: Lens Address String
state = lens _.state (_ { state = _ })

testPerson :: Person
testPerson = { first:   "John"
             , last:    "Smith"
             , address: { street: "123 Fake St."
                        , city: "Faketown"
                        , state: "CA"
                        }
             }

main :: Effect Unit
main = do
  let testPerson' = set (state <<< address) "AZ" testPerson

  log $ testPerson ^. state <<< address
  log $ testPerson' ^. state <<< address
