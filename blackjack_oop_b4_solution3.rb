# encoding: UTF-8
require 'rubygems'
require 'pry'

# Hand module
module Hand
  player_cards = []
  dealer_cards = []
  player_score = 0
  dealer_score = 0
end

# Card class
class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def fancy_output
    puts "The #{face_value} of #{find_suit}"
  end

  def to_s
    fancy_output
  end

  def find_suit
    case suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end
end

# Deck class
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    %w( H D S C).each do |suit|
      %w( 2 3 4 5 6 7 8 9 10 J Q K A).each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

# Dealer class
class Dealer
  def says
    puts 'Press H for Hit or S for Stay'
  end
end

# Player class
class Player
  attr_accessor :name

  def initialize(n)
    @name = n
  end
end

p1 = Player.new('Dave')
p p1.name

# deck = Deck.new
# binding.pry
# puts deck.cards
# puts deck.size
# puts deck.deal_one
# puts deck.size

dealer =  Dealer.new
p dealer.says
