class ComputerPlayer < Player
  def handle_move(controller)
    next_move_index = available_moves(controller).sample
    y = next_move_index / 3
    x = next_move_index % 3

    controller.game_field.place_player(self, y, x)
    true
  end

  private

  def available_moves(controller)
    available_indexes = []

    controller.game_field.fields.flatten.each_with_index do |field, index|
      available_indexes.push(index) if field.current == '-'
    end
    available_indexes
  end
end
