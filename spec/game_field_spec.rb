require './lib/tic_tac_toe/game_field'

describe GameField do
  let(:field) { described_class.new }
  let(:win_checker) { double('win checker') }
  let(:validator) { double('validator') }

  before do
    allow(BoardWinChecker).to receive(:new).and_return(win_checker)
  end

  describe '#winner_move?' do
    it 'Sends winner_move command' do
      expect(win_checker).to receive(:winner_move?)
      field.winner_move?('X')
    end
  end

  describe '#restart' do
    before do
      @fields = field.instance_variable_get(:@fields).flatten
    end

    it 'calls reset for each field' do
      @fields.each { |field| expect(field).to receive(:reset).once }
      field.restart
    end
  end

  describe '#any_move_exist?' do
    let(:mock_fields) { Array.new(1) { Array.new(2) { double('field') } } }
    let(:specific_field) { double('field') }
    before do
      allow(Field).to receive(:new).and_return(specific_field)
      allow(specific_field).to receive(:occupied?).and_return(false)
    end
    context 'when gamefield is newly created' do
      it 'returns true' do
        move_exist = field.any_move_exist?
        expect(move_exist).to eq(true)
      end
    end

    context 'when gamefield has every but 1 field occupied' do
      before do
        allow(specific_field).to receive(:occupied?).and_return(false, true, true)
      end
      before do
      end

      it 'returns true' do
        move_exist = field.any_move_exist?
        expect(move_exist).to eq(true)
      end
    end

    context 'when gamefield has every field occupied' do
      before do
        allow(specific_field).to receive(:occupied?).and_return(true)
      end

      it 'returns false' do
        move_exist = field.any_move_exist?
        expect(move_exist).to eq(false)
      end
    end
  end
end
