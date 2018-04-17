class Game
  attr_accessor :board

  NO_MOVE = -1
  POSITIONS_ON_BOARD = (0..8)

  def initialize(board, position=nil, player=nil)
    @board = board.dup
    @board[position] = player unless position == nil
  end

  def best_move_for(player)
    move = NO_MOVE
    POSITIONS_ON_BOARD.each do |position|
      if position_unoccupied?(position)
        move = position if winning_move?(position, player) || move == NO_MOVE
      end
    end

    return move
  end

  def winning_move?(square, player)
    game = Game.new(board, square, player)
    game.winner == player
  end

  def winner
    first_position_in_rows = [0, 3, 6]
    first_position_in_rows.each { |position|  return mark_at(position) if winning_row(position) }
    first_position_in_columns = [0, 1, 2]
    first_position_in_columns.each { |position| return mark_at(position) if winning_column(position) }
    first_position_in_left_diagonal = 0
    return mark_at(first_position_in_left_diagonal) if winning_left_diagonal(first_position_in_left_diagonal)
    first_position_in_right_diagonal = 2
    return mark_at(first_position_in_right_diagonal) if winning_right_diagonal(first_position_in_right_diagonal)
    return '-'
  end

  def winning_row(position)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position.next) &&
    mark_at(position.next) == mark_at(position.next.next)
  end

  def winning_column(position)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position + 3) &&
    mark_at(position + 3) == mark_at(position + 6)
  end

  def winning_left_diagonal(position)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position + 4) &&
    mark_at(position + 4) == mark_at(position + 8)
  end

  def winning_right_diagonal(position)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position + 2) &&
    mark_at(position + 4) == mark_at(position + 4)
  end

  def position_unoccupied?(position)
    mark_at(position) == '-'
  end

  def position_occupied?(position)
    mark_at(position) != '-'
  end

  def mark_at(position)
    board[position]
  end
end
