class Player
  attr_reader :symbol, :score

  def initialize(name, symbol)
    @symbol = symbol
    @name = name
    @score = 0
  end

  def win
    @score += 1
  end

  def handle_move(controller)
    input = gets.chomp.downcase

    return controller.quit_game if wants_quit?(input)

    board = controller.game_field
    first, second, * = input.split

    unless board.correct_move?(first, second)
      puts 'Wrong input, Type row & column fe. "2 1"'
      return false
    end

    board.place_player(self, first.to_i, second.to_i)
    true
  end

  def to_s
    "#{@name}"
  end

  def full_data
    "#{self}: Wins: #{@score}"
  end

  private

  def wants_quit?(input)
    input.downcase == 'exit'
  end
end
