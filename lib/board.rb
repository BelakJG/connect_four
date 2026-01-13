class Board
  attr_accessor :board

  EMPTY = "\u2b55".freeze

  def initialize
    @board = Array.new(6) { Array.new(7, EMPTY) }
  end

  def print_board(board = @board)
    system('clear')
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
    return false if column.nil? || column < 0 || column > 6

    board.each do |row|
      return true if row[column] == EMPTY
    end
    false
  end

  def scan_rows(board = @board)
    board.each do |row|
      (0..3).each do |n|
        next if row[n] == EMPTY

        return true if row[n] == row[n + 1] &&
                       row[n] == row[n + 2] &&
                       row[n] == row[n + 3]
      end
    end
    false
  end

  def scan_cols(board = @board)
    (0..6).each do |column|
      5.downto(3).each do |row|
        next if board[row][column] == EMPTY

        return true if board[row][column] == board[row - 1][column] &&
                       board[row][column] == board[row - 2][column] &&
                       board[row][column] == board[row - 3][column]
      end
    end
    false
  end

  def scan_diags(board = @board)
    # right leaning diags
    (0..3).each do |column|
      5.downto(3).each do |row|
        next if board[row][column] == EMPTY

        return true if board[row][column] == board[row - 1][column + 1] &&
                       board[row][column] == board[row - 2][column + 2] &&
                       board[row][column] == board[row - 3][column + 3]
      end
    end

    # left leaning diags
    6.downto(3).each do |column|
      5.downto(3).each do |row|
        next if board[row][column] == EMPTY

        return true if board[row][column] == board[row - 1][column - 1] &&
                       board[row][column] == board[row - 2][column - 2] &&
                       board[row][column] == board[row - 3][column - 3]
      end
    end

    false
  end

  def scan_all(board = @board)
    scan_cols(board) ||
      scan_rows(board) ||
      scan_diags(board)
  end
end
