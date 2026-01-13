require_relative './player'
require_relative './board'

class Game
  attr_accessor :player_one, :player_two, :board, :current_turn, :winner

  def initialize
    @player_one = Player.new("\u26aa")
    @player_two = Player.new("\u26ab")
    @board = Board.new
    @current_turn = player_one
    @winner = nil
  end

  def print_board
    board.print_board
  end

  def swap_turn
    @current_turn = @current_turn == @player_one ? @player_two : @player_one
  end

  def board_full?
    (0...7).each do |n|
      return false if board.valid_col?(n)
    end
    true
  end

  def gameover?
    if board.scan_all
      @winner = current_turn
      return true
    end
    board_full?
  end

  def computer_turn
    col = rand(0..6) until board.valid_col?(col)
    board.drop_token(col, current_turn.color)
  end

  def player_turn
    print 'Please enter what column to drop your token: '
    col = gets.chomp.to_i
    until board.valid_col?(col)
      print "Error: #{col} is not a valid column, please enter a new one: "
      col = gets.chomp.to_i
    end
    board.drop_token(col, current_turn.color)
  end

  def play_game
    print 'would you like to be player one or two: '
    response = gets.chomp.capitalize
    if response == 'Two'
      computer_turn
      swap_turn
    end
    loop do
      print_board
      player_turn
      break if gameover?

      swap_turn

      computer_turn
      break if gameover?

      swap_turn
    end
    board.print_board
    if winner == player_one
      puts "Player One #{player_one.color} Wins!"
    elsif winner == player_two
      puts "Player Two #{player_two.color} Wins!"
    else
      puts 'No one wins! The board is full!'
    end
  end
end
