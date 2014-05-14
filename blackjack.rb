# encoding: UTF-8
module Hand
  # who is holding what?
end

class Blackjack
  # game play?
end

class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def fancy_output
    puts "The #{@face_value} of #{@suit}"
  end
end

class Deck
  attr_accessor :deck

  def initialize(d)
    @deck = d
  end
 
  def display_deck
    puts "The Dealer's suffled deck looks like this #{@deck}"
  end
end

class Dealer
  # rules and gate keeper?
end

class Player
  attr_accessor :name
  def initialize(n)
    @name = n
  end
end

class Scores
end

c1 = Card.new('H', '3')
c2 = Card.new('D', '4')

c1.fancy_output
c2.fancy_output

puts c1.suit
puts c2.suit

c1.suit = "New Suit for C1"
c2.suit = "New Suit for C2"

puts c1.suit
puts c2.suit

s = ['C', 'S', 'D', 'H']
c = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

d = s.product(c) # prefer my cards called by number then suit
d.shuffle!
d1 = Deck.new(d)
d1.display_deck

p1 = Player.new('Dave')
p p1.name
