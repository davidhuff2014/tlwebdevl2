# encoding: UTF-8
require 'rubygems'
require 'pry'

# Hand module
module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards. each { |card| puts "=> #{card}" }
    puts "=> Total: #{total}"
  end

  def total
    face_values = cards.map { |card| card.face_value }

    total = 0
    face_values. each { |val| val == 'A' ? total += 11 : val.to_i == 0 ? \
      total +=  10 : total += val.to_i }
    face_values.select { |val| val == 'A' }.count.times { total <= 21 ? \
      break : total -= 10 }
    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

# Card class
class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def fancy_output
    "The #{face_value} of #{find_suit}"
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
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = 'Dealer'
    @cards = []
  end

  def says
    puts 'Press H for Hit or S for Stay'
  end
end

# Player class
class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end
end

deck = Deck.new

player = Player.new('Dave')
player.add_card(deck.deal_one)
player.add_card(deck.deal_one)
player.add_card(deck.deal_one)
player.add_card(deck.deal_one)
player.show_hand

p player.busted?

dealer =  Dealer.new
dealer.add_card(deck.deal_one)
dealer.add_card(deck.deal_one)
dealer.add_card(deck.deal_one)
dealer.add_card(deck.deal_one)
dealer.show_hand
p dealer.says

p dealer.busted?
