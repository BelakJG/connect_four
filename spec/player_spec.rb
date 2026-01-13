require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when no color is specified for player' do
      subject(:white) { described_class.new }
      it 'defaults to a white circle' do
        expect(white.color).to eq('⚪')
      end
    end

    context 'when a symbol is specified' do
      subject(:black) { described_class.new("\u26ab") }
      it 'stores given character' do
        expect(black.color).to eq('⚫')
      end
    end
  end
end
