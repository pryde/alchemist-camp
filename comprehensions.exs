suits = ["spades", "hearts", "clubs", "diamonds"]
values = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

cards = for value <- values, suit <- suits, do: value <> " of " <> suit

IO.inspect cards