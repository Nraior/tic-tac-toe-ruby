require_relative './game_field'

class GameController
  attr_reader :game_field

  def initialize
    @game_field = GameField.new
    @players = []
    @round_count = 0
    @games_count = 0
    @playing = false
    @force_quit = false
  end

  def add_player(player)
    @players.push(player)
  end

  def start_game
    @games_count += 1
    return if @players.count < 2

    @force_quit = false
    game_field.restart
    @round_count = 0
    @playing = true

    puts 'GAME STARTED'
    puts 'TYPE "exit" to finish early'
    game_loop

    handle_restart_check unless @force_quit
  end

  def quit_game
    puts 'Quit the game'
    @playing = false
    @force_quit = true
  end

  def end_game
    @playing = false
    show_scoreboard
    true
  end

  private

  def any_move_exist?
    game_field.any_move_exist?
  end

  def draw
    puts 'Draw!'
    end_game
  end

  def check_for_win(current)
    handle_win(current) if game_field.winner_move?(current.symbol)
  end

  def handle_win(player)
    puts "\nYaay! we have winner! #{player}"
    player.win
    show_board
    show_scoreboard
    @playing = false
  end

  def show_scoreboard
    @players.each { |player| puts player.full_data }
  end

  def handle_restart_check
    puts 'Do you want to restart the game? press y'
    restart_game = gets.chomp.downcase == 'y'
    return unless restart_game

    puts 'Restarting!'
    puts '____________'
    start_game
  end

  def show_board
    puts game_field
  end

  def game_loop
    while @playing
      current_player = @players[(@round_count + (@games_count - 1)) % 2]
      puts "\nCurrent Player Symbol: #{current_player.symbol}"
      show_board

      player_move = current_player.handle_move(self)
      next unless player_move

      check_for_win(current_player)

      draw if @playing && !any_move_exist?

      @round_count += 1
    end
  end
end
