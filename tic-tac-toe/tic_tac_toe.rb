class Game
  attr_accessor :board

  NO_MOVE = -1
  SQUARES_ON_BOARD = (0..8)

  def initialize(s, position=nil, player=nil)
    @board = s.dup
    @board[position] = player unless position == nil
  end

  def best_move_for(player)
    move = NO_MOVE
    SQUARES_ON_BOARD.each do |square|
      if square_unoccupied?(square)
        move = square if winning_move?(square, player) || move == NO_MOVE
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
    first_position_in_rows.each { |position|  return winning_player(position) if winning_player(position) }
    return '-'
  end

  def winning_player(position)
    if board[position] != '-' && board[position] == board[position.next] && board[position.next] == board[position.next.next]
      return board[position]
    end
  end

  def square_unoccupied?(square)
    board[square] == '-'
  end
end
