class Game
  attr_accessor :board

  NO_MOVE = -1
  POSITIONS_ON_BOARD = (0..8)

  def initialize(s, position=nil, player=nil)
    @board = s.dup
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
    first_position_in_rows.each { |position|  return mark_at(position) if winning_player(position) }
    return '-'
  end

  def winning_player(position)
    position_occupied?(position) &&
    mark_at(position) == mark_at(position.next) &&
    mark_at(position.next) == mark_at(position.next.next)
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
