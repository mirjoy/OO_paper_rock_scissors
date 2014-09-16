class Hand
  include Comparable

  attr_reader :name, :value, :choice, :hand

  CHOICES = {'P' => 'Paper', 'R' => 'Rock', 'S' => 'Scissors'}

  def initialize(n)
    @name = n
  end

  def <=>(another_hand)
    if @choice == another_hand.choice
      0
    elsif (@choice == 'P' && another_hand.choice == "R") || (@choice == 'R' && another_hand.choice == "S") || (@choice == 'S' && another_hand.choice == "P") 
      1
    else
      -1
    end 
  end

  def display_winning_message
    case @choice
    when 'P'
      puts "Paper wraps rock!"
    when 'R'
      puts "Rock smashes scissors!"
    when 'S'
      puts "Scissors cut paper!"
    end
  end

end

class Player < Hand

  def initialize
    puts "What is your name?"
    @name = gets.chomp
  end

  def player_choice
    begin
    puts "#{name}, what do you choose, Paper, Scissors or Rock? [P/R/S]"
    @choice = gets.chomp.upcase!
    end until CHOICES.keys.include?(choice)
    puts "#{name} chooses #{CHOICES.values_at(choice).join}"
  end

end

class Computer < Hand 
  def initialize
    @name = "Computer"
  end

  def computer_choice
    @choice = CHOICES.keys.sample
    puts "The #{name} chooses #{CHOICES.values_at(choice).join}"
  end

end

class Game
 attr_reader :human, :comp

  def initialize
    @human = Player.new
    @comp = Computer.new
  end

  def compare_choices
    if human.choice == comp.choice
      puts "It's a tie"  
    elsif human.choice > comp.choice
      puts "#{human.name} wins!"
      human.display_winning_message
    else
      puts "Computer wins"
      comp.display_winning_message
    end
  end

  def play
    human.player_choice
    comp.computer_choice
    compare_choices
  end

end

game = Game.new.play
