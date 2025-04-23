require './lib/tic_tac_toe/player'
require './lib/tic_tac_toe/game_controller'

describe Player do
  subject(:player) { described_class.new('Damien', 'X') }
  let(:board) { double('board') }

  describe '#win' do
    it 'changes score' do
      expect { player.win }.to change { player.score }.by(1)
    end
  end

  describe '#handle_move' do
    let(:controller) { instance_double(GameController) }
    before do
      allow(controller).to receive(:puts)
      allow(controller).to receive(:quit_game)
      allow(controller).to receive(:game_field).and_return(board)
    end

    context 'when input is exit' do
      before do
        allow(player).to receive(:gets).and_return('exit')
      end
      it 'returns early' do
        expect(controller).not_to receive(:game_field)
        expect(controller).to receive(:quit_game).once
        player.handle_move(controller)
      end
    end

    context 'when input is incorrect' do
      before do
        allow(player).to receive(:gets).and_return('b a')
        allow(board).to receive(:correct_move?)
        allow(player).to receive(:puts)
      end
      it 'returns false' do
        result = player.handle_move(controller)
        expect(result).to eq(false)
      end
    end

    context 'when input is correct' do
      before do
        allow(player).to receive(:gets).and_return('1 2')
        allow(board).to receive(:correct_move?).and_return(true)
        allow(board).to receive(:place_player)
      end

      it 'sends place player command to board' do
        expect(board).to receive(:place_player)
        player.handle_move(controller)
      end

      it 'returns true' do
        move = player.handle_move(controller)
        expect(move).to eq(true)
      end
    end
  end
end
