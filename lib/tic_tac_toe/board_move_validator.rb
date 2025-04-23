class BoardMoveValidator
  def valid_move?(first, second, fields)
    first_is_number = first.to_i.to_s == first
    second_is_number = second.to_i.to_s == second

    return false unless first_is_number && second_is_number

    first_number_in_range = first.to_i.between?(0, 2)
    second_number_in_range = second.to_i.between?(0, 2)
    return false unless first_number_in_range && second_number_in_range

    !fields[first.to_i][second.to_i].occupied?
  end
end
