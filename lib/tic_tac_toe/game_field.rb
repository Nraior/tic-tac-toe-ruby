require_relative 'field'
require_relative 'board_win_checker'
require_relative 'board_move_validator'
class GameField
  attr_reader :fields

  def initialize(height = 3, width = 3)
    @height = height
    @width = width
    @fields = create_fields(height, width)
    @win_checker = BoardWinChecker.new
    @validator = BoardMoveValidator.new
  end

  def winner_move?(player_symbol)
    @win_checker.winner_move?(player_symbol, @fields)
  end

  def restart
    fields.flatten.each(&:reset)
  end

  def any_move_exist?
    fields.flatten.any? { |field| !field.occupied? }
  end

  def field(field_row, field_column)
    fields.dig(field_row, field_column)
  end

  def place_player(player, first, second)
    field(first, second).occupy(player.symbol)
  end

  def correct_move?(first, second)
    @validator.valid_move?(first, second, fields)
  end

  def to_s
    text = ''
    fields.each do |field_arr|
      field_arr.each do |field|
        text += "#{field} "
      end
      text += "\n"
    end
    text
  end
end

private

def create_fields(height, width)
  Array.new(height) { Array.new(width) { Field.new } }
end
