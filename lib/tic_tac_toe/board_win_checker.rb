class BoardWinChecker
  def winner_move?(player_symbol, fields)
    standard_win?(player_symbol, fields) || crosses_win?(player_symbol, fields)
  end

  private

  def standard_win?(symbol, fields)
    (0..2).each do |y|
      x_win = true
      y_win = true
      (0..2).each do |x|
        x_win = false if symbol != fields[y][x].current
        y_win = false if symbol != fields[x][y].current
      end
      return true if x_win || y_win
    end
    false
  end

  def crosses_win?(symbol, fields)
    cross_left_win = true
    cross_right_win = true
    (0..2).each do |y|
      cross_left_win = false if symbol != fields[y][y].current
      cross_right_win = false if symbol != fields[y][2 - y].current
    end
    cross_left_win || cross_right_win
  end
end
