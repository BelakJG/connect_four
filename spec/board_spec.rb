require_relative '../lib/board'

describe Board do
  describe '#drop_token' do
    subject(:game_board) { described_class.new }
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
end
