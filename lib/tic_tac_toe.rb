require_relative 'tic_tac_toe/game_controller'
require_relative 'tic_tac_toe/player'
require_relative 'tic_tac_toe/computer_player'

game = GameController.new
game.add_player(Player.new('Andrew', 'X'))
# game.add_player(Player.new('Daniel', 'Y'))
game.add_player(ComputerPlayer.new('Bot George', 'Y'))

game.start_game
