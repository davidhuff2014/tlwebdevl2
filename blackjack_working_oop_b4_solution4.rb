# encoding: UTF-8
# require 'rubygems'
# require 'pry' # for binding.pry

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

def yesno
  begin
    system('stty raw -echo')
    str = STDIN.getc
  ensure
    system('stty -raw echo')
  end
  if str == 'y'
    puts 'Play Game!'
    deal
  elsif str == 'n'
    puts 'Thank you for playing!'
    exit
  else
    puts 'Please press y to play game or n to end'
    yesno
  end
end

def hitstay
  begin
    system('stty raw -echo')
    str = STDIN.getc
  ensure
    system('stty -raw echo')
  end
  if str == 'h'
    # puts 'Hit me!'
    $flag = true
    return true
  elsif str == 's'
    # puts 'Stay!'
    $flag = true
    return false
  else
    puts 'Please press h to hit or s to stay'
    hitstay
  end
end

def deal
  if $flag == true
    player_name = $playername
    puts "Welcome Back #{player_name}!"
  else
    puts 'Player please enter your name'
    player_name = gets.chomp
    $playername = player_name
  end
  player = Player.new(player_name)
  deck = Deck.new
  dealer =  Dealer.new
  player.add_card(deck.deal_one)
  dealer.add_card(deck.deal_one)
  player.add_card(deck.deal_one)
  dealer.add_card(deck.deal_one)
  player.show_hand
  dealer.show_hand
  puts "#{player_name} please press h to hit or s to stay"
  hitstay
  while hitstay == true
    player.add_card(deck.deal_one)
    player.show_hand
    if player.busted?
      puts "#{player_name} has lost!"
      play_again?
    end
    puts "#{player_name} please press h to hit or s to stay"
    hitstay
  end

  while dealer.total < 17
    dealer.add_card(deck.deal_one)
    dealer.show_hand
  end
  if dealer.total <= 21 && dealer.total >= player.total
    puts 'Dealer wins!'
    play_again?
  end
  if dealer.busted?
    puts 'Dealer has lost!'
    play_again?
  end
  if dealer.total < player.total
    puts "#{player_name} has won!"
    play_again?
  end
end

def play_again?
  puts 'Do you want to play again press y or n ?'
  yesno
end

def play_game?
  puts 'Do you want to play blackjack press y or n ?'
  yesno
end

play_game?
