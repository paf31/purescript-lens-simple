module Test.Main where

import Data.Lens

import Debug.Trace

newtype Person = Person { first :: String, last :: String, address :: Address }

newtype Address = Address { street :: String, city :: String, state :: String }

first :: Lens Person String
first = lens (\(Person p) -> p.first) (\(Person p) s -> Person (p { first = s }))

last :: Lens Person String
last = lens (\(Person p) -> p.last) (\(Person p) s -> Person (p { last = s }))

address :: Lens Person Address
address = lens (\(Person p) -> p.address) (\(Person p) a -> Person (p { address = a }))

street :: Lens Address String
street = lens (\(Address a) -> a.street) (\(Address a) s -> Address (a { street = s }))

city :: Lens Address String
city = lens (\(Address a) -> a.city) (\(Address a) s -> Address (a { city = s }))

state :: Lens Address String
state = lens (\(Address a) -> a.state) (\(Address a) s -> Address (a { state = s }))

testPerson :: Person
testPerson = Person { first:   "John"
                    , last:    "Smith" 
                    , address: Address { street: "123 Fake St."
                                       , city: "Faketown"
                                       , state: "CA"
                                       }
                    }

main = do
  trace $ (state <<< address) `get` testPerson
  let testPerson' = set (state <<< address) "AZ" testPerson
  trace $ (state <<< address) `get` testPerson'
