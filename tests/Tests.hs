{-# LANGUAGE UnicodeSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

import Test.Framework (defaultMain)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Data.Word (Word)
import Data.Char (intToDigit)
import Numeric (showIntAtBase)
import Text.Printf (printf)
import Text.Printer

main = defaultMain
  [ testProperty "unsignedBinary" $ \w →
      unsignedBinary w == showBinary (w ∷ Word)
  , testProperty "unsignedOctal" $ \w →
      unsignedOctal w == (printf "%o" (w ∷ Word) ∷ String)
  , testProperty "unsignedDecimal" $ \w →
      unsignedDecimal w == show (w ∷ Word)
  , testProperty "unsignedLowHex" $ \w →
      unsignedLowHex w == (printf "%x" (w ∷ Word) ∷ String)
  , testProperty "unsignedUpHex" $ \w →
      unsignedUpHex w == (printf "%X" (w ∷ Word) ∷ String)
  , testProperty "binary" $ \i →
      if (i ∷ Int) == 0
      then binary i == "0"
      else if i < 0
           then binary i == '-' : showBinary (negate $ toInteger i)
           else binary i == showBinary i
  , testProperty "octal" $ \i →
      if (i ∷ Int) == 0
      then octal i == "0"
      else if i < 0
           then octal i == (printf "-%o" (negate $ toInteger i) ∷ String)
           else octal i == (printf "%o" i ∷ String)
  , testProperty "lowHex" $ \i →
      if (i ∷ Int) == 0
      then lowHex i == "0"
      else if i < 0
           then lowHex i == (printf "-%x" (negate $ toInteger i) ∷ String)
           else lowHex i == (printf "%x" i ∷ String)
  , testProperty "upHex" $ \i →
      if (i ∷ Int) == 0
      then upHex i == "0"
      else if i < 0
           then upHex i == (printf "-%X" (negate $ toInteger i) ∷ String)
           else upHex i == (printf "%X" i ∷ String)
  , testProperty "decimal" $ \i →
      decimal i == show (i ∷ Int)
  ]

showBinary i = showIntAtBase 2 intToDigit i ""

