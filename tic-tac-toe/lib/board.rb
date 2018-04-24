class Board
  attr_accessor :state

  NO_MOVE = -1
  POSITIONS_ON_BOARD = (0..8)

  GAME_AI = {
    row: { step: 1, first_positions: [0, 3, 6] },
    column: { step: 3, first_positions: [0, 1, 2] },
    left_diagonal: { step: 4, first_positions: [0] },
    right_diagonal: { step: 2, first_positions: [2] },
  }

  def initialize(state = "---------")
    @state = state
  end

  def best_move_for(player)
    move = NO_MOVE
    POSITIONS_ON_BOARD.each do |position|
      if position_unoccupied?(position)
        move = position if winning_move?(player) || move == NO_MOVE
      end
    end

    return move
  end

  def winning_move?(player)
    winner == player
  end

  def winner
    GAME_AI.each do |direction, attrs|
      attrs[:first_positions].any? do |position|
        return mark_at(position) if winning_combo?(position, attrs[:step])
      end
    end
  end

  def winning_combo?(position, step)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position + step) &&
    mark_at(position + step) == mark_at(position + step * 2)
  end

  def position_unoccupied?(position)
    mark_at(position) == '-'
  end

  def position_occupied?(position)
    mark_at(position) != '-'
  end

  def mark_at(position)
    state[position]
  end
end
