require_relative '../lib/board'

describe Board do
  subject(:game_board) { described_class.new }
  describe '#drop_token' do
    context 'when a column is given' do
      empty = "\u2b55"
      it 'stores a token in the lowest possible location' do
        game_board.drop_token(2)
        expect(game_board.board.last).to eq([empty, empty, "\u26aa", empty, empty, empty, empty]) # [⭕,⭕,⚪,⭕,⭕,⭕,⭕]
      end
      it 'stacks if a token is under it' do
        game_board.drop_token(2)
        game_board.drop_token(2, "\u26ab")
        expect(game_board.board[4]).to eq([empty, empty, "\u26ab", empty, empty, empty, empty]) # [⭕,⭕,⚫,⭕,⭕,⭕,⭕]
      end
    end
  end

  describe '#valid_col?' do
    subject(:game_board) { Board.new }
    context 'when column has empty slot' do
      it 'returns true' do
        expect(game_board.valid_col?(3)).to be true
      end
    end

    context 'when column is full' do
      before do
        6.times { game_board.drop_token(3) }
      end
      it 'returns false' do
        expect(game_board.valid_col?(3)).to be false
      end
    end
  end

  describe '#scan_row' do
    context 'when a row has four in a row' do
      before do
        (0..3).each do |n|
          game_board.drop_token(n)
        end
      end
      it 'returns true' do
        expect(game_board.scan_rows).to be true
      end
    end
    context 'when a row does not have four in a row' do
      it 'returns false' do
        expect(game_board.scan_rows).to be false
      end
    end
  end

  describe '#scan_cols' do
    context 'when a column has four in a row' do
      before do
        4.times { game_board.drop_token(4) }
      end
      it 'returns true' do
        expect(game_board.scan_cols).to be true
      end
    end
    context 'when a column does not have four in a row' do
      it 'returns false' do
        expect(game_board.scan_cols).to be false
      end
    end
  end

  describe '#scan_diags' do
    context 'when a diagnol has four in a row' do
      temp_board_right = [%w[⭕ ⭕ ⭕ ⭕ ⭕ ⭕ ⭕],
                          %w[⭕ ⭕ ⭕ ⭕ ⭕ ⭕ ⭕],
                          %w[⭕ ⭕ ⭕ ⭕ ⭕ ⭕ ⚪],
                          %w[⭕ ⭕ ⭕ ⭕ ⭕ ⚪ ⭕],
                          %w[⭕ ⭕ ⭕ ⭕ ⚪ ⭕ ⭕],
                          %w[⭕ ⭕ ⭕ ⚪ ⭕ ⭕ ⭕]]

      temp_board_left = [%w[⚪ ⭕ ⭕ ⭕ ⭕ ⭕ ⭕],
                         %w[⭕ ⚪ ⭕ ⭕ ⭕ ⭕ ⭕],
                         %w[⭕ ⭕ ⚪ ⭕ ⭕ ⭕ ⭕],
                         %w[⭕ ⭕ ⭕ ⚪ ⭕ ⭕ ⭕],
                         %w[⭕ ⭕ ⭕ ⭕ ⭕ ⭕ ⭕],
                         %w[⭕ ⭕ ⭕ ⭕ ⭕ ⭕ ⭕]]
      it 'returns true when right leanign' do
        expect(game_board.scan_diags(temp_board_right)).to be true
      end

      it 'returns true when left leaning' do
        expect(game_board.scan_diags(temp_board_left)).to be true
      end
    end
    context 'when a diagnol does not have four in a row' do
      it 'returns false' do
        expect(game_board.scan_diags).to be false
      end
    end
  end
end
