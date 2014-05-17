# encoding: UTF-8
# require 'rubygems'
# require 'pry' # for binding.pry

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
    face_values.select { |val| val == 'A' }.count.times { total <= Blackjack::BLACKJACK_AMOUNT ? \
      break : total -= 10 }
    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > Blackjack::BLACKJACK_AMOUNT
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

  def show_flop
    show_hand
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

  def show_flop
    puts "---- Dealer's Hand ----"
    puts '=> First card is hidden'
    puts "=> Second cards is #{cards[1]}"
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
    primer
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

# new driver class (game engine)
class Blackjack
  attr_accessor :deck, :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new
    @player = Player.new('Player1')
    @dealer = Dealer.new
  end

  def set_player_name
    if $flag == true
      player.name = $playername
      puts "Welcome Back #{player.name}!"
    else
      puts 'Player please enter your name'
      player.name = gets.chomp
      $playername = player.name
    end
  end

  def deal_cards
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    if player.total == BLACKJACK_AMOUNT
      puts "#{player.name} has blackjack and stays!"
    else
      puts "#{player.name} please press h to hit or s to stay"
      hitstay
      while hitstay == true
        player.add_card(deck.deal_one)
        player.show_hand
        if player.total == BLACKJACK_AMOUNT
          puts "#{player.name} has blackjack and stays!"
          break
        end
        if player.busted?
          puts "#{player.name} has lost!"
          play_again?
        end
        puts "#{player.name} please press h to hit or s to stay"
        hitstay
      end
    end
    puts "#{player.name} stays!"
  end

  def dealer_turn
    while dealer.total < DEALER_HIT_MIN
      dealer.add_card(deck.deal_one)
      dealer.show_hand
    end
    if dealer.total <= BLACKJACK_AMOUNT && dealer.total >= player.total
      dealer.show_hand
      puts 'Dealer wins!'
      play_again?
    end
    if dealer.busted?
      dealer.show_hand
      puts 'Dealer has lost!'
      play_again?
    end
    if dealer.total < player.total
      dealer.show_hand
      puts "#{player.name} has won!"
      play_again?
    end
  end

  def start
    set_player_name
    deal_cards
    show_flop
    player_turn
    dealer_turn
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

def primer
  game = Blackjack.new
  game.start
end

play_game?
