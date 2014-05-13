# encoding: UTF-8
module Hand
  # who is holding what?
end

class Blackjack
  # game play?
end

class Cards
  # inherits from hand?
end

class Deck
  attr_accessor :deck
  suits = ['C', 'S', 'D', 'H']

  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  $deck = cards.product(suits) # prefer my cards called by number then suit
  $deck.shuffle!
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

Deck.new
p $deck
p1 = Player.new('Dave')
p p1.name
