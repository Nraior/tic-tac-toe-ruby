require './lib/tic_tac_toe/board_win_checker'
describe BoardWinChecker do
  describe 'winner_move' do
    context 'when no move is done' do
      let(:fields) do
        [
          [double('Cell', current: nil), double('Cell', current: nil), double('Cell', current: nil)],
          [double('Cell', current: nil), double('Cell', current: nil), double('Cell', current: nil)],
          [double('Cell', current: nil), double('Cell', current: nil), double('Cell', current: nil)]
        ]
      end
      it 'returns false for x player' do
        win = subject.winner_move?('x', fields)
        expect(win).to be(false)
      end
    end

    context 'when x player is winning vertically' do
      let(:fields) do
        [
          [double('Cell', current: 'x'), double('Cell', current: nil), double('Cell', current: nil)],
          [double('Cell', current: 'x'), double('Cell', current: nil), double('Cell', current: nil)],
          [double('Cell', current: 'x'), double('Cell', current: nil), double('Cell', current: nil)]
        ]
      end
      it 'returns true for x player' do
        result = subject.winner_move?('x', fields)
        expect(result).to be(true)
      end

      it 'returns false for o player' do
        result = subject.winner_move?('o', fields)
        expect(result).to be(false)
      end
    end

    context 'when x player is winning horizontally' do
      let(:fields) do
        [
          [double('Cell', current: 'o'), double('Cell', current: 'o'), double('Cell', current: nil)],
          [double('Cell', current: 'x'), double('Cell', current: 'x'), double('Cell', current: 'x')],
          [double('Cell', current: 'o'), double('Cell', current: nil), double('Cell', current: nil)]
        ]
      end
      it 'returns true for x player' do
        result = subject.winner_move?('x', fields)
        expect(result).to be(true)
      end

      it 'returns false for o player' do
        result = subject.winner_move?('o', fields)
        expect(result).to be(false)
      end
    end

    context 'when there is crosses win' do
      context 'when x player has cross filled one upper left - lower right cross' do
        let(:fields) do
          [
            [double('Cell', current: 'x'), double('Cell', current: nil), double('Cell', current: nil)],
            [double('Cell', current: nil), double('Cell', current: 'x'), double('Cell', current: nil)],
            [double('Cell', current: nil), double('Cell', current: nil), double('Cell', current: 'x')]
          ]
        end
        it 'returns true for x player' do
          result = subject.winner_move?('x', fields)
          expect(result).to be(true)
        end

        it 'returns false for o player' do
          result = subject.winner_move?('o', fields)
          expect(result).to be(false)
        end
      end

      context 'when x player has cross filled one upper right - lower left cross' do
        let(:fields) do
          [
            [double('Cell', current: nil), double('Cell', current: nil), double('Cell', current: 'x')],
            [double('Cell', current: nil), double('Cell', current: 'x'), double('Cell', current: nil)],
            [double('Cell', current: 'x'), double('Cell', current: nil), double('Cell', current: nil)]
          ]
        end
        it 'returns true for x' do
          result = subject.winner_move?('x', fields)
          expect(result).to be(true)
        end

        it 'returns false for o' do
          result = subject.winner_move?('o', fields)
          expect(result).to be(false)
        end
      end
    end

    context 'when there is draw' do
      let(:fields) do
        [
          [double('Cell', current: 'x'), double('Cell', current: 'x'), double('Cell', current: 'o')],
          [double('Cell', current: 'o'), double('Cell', current: 'x'), double('Cell', current: 'x')],
          [double('Cell', current: 'x'), double('Cell', current: 'o'), double('Cell', current: 'o')]
        ]
      end
      it 'returns false for x player' do
        result = subject.winner_move?('x', fields)
        expect(result).to be(false)
      end

      it 'returns false for o player' do
        result = subject.winner_move?('o', fields)
        expect(result).to be(false)
      end
    end
  end
end
