require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#swap_turn' do
    context 'when turn is over' do
      let(:one) { game.instance_variable_get(:@player_one) }
      let(:two) { game.instance_variable_get(:@player_two) }
      it 'swaps from player one to player two' do
        expect { game.swap_turn }.to change(game, :current_turn).to(two)
      end

      it 'swaps from player two to player one' do
        game.instance_variable_set(:@current_turn, two)
        expect { game.swap_turn }.to change(game, :current_turn).to(one)
      end
    end
  end

  describe '#board_full?' do
    it 'returns false if board is not full' do
      expect(game.board_full?).to be false
    end
  end
end
