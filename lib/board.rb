class Board
  attr_accessor :board

  EMPTY = "\u2b55".freeze

  def initialize
    @board = Array.new(6) { Array.new(7, EMPTY) }
  end

  def print_board(board = @board)
    puts ' 0  1  2  3  4  5  6'
    board.each do |row|
      row.each do |slot|
        print "#{slot} "
      end
      puts ''
    end
  end

  def drop_token(column, color = "\u26aa")
    board.reverse_each do |row|
      if row[column] == "\u2b55"
        row[column] = color
        break
      end
    end
  end

  def valid_col?(column)
    board.each do |row|
      return true if row[column] == EMPTY
    end
    false
  end
end
