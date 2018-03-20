class Game
  attr_accessor :board

  NO_MOVE = -1
  SQUARES_ON_BOARD = (0..8)

  def initialize(s, position=nil, player=nil)
    @board = s.dup
    @board[position] = player unless position == nil
  end

  def best_move_for(player)
    SQUARES_ON_BOARD.each do |square|
      if square_unoccupied?(square)
        game = create_new_game_for(square, player)
        return square if game.winner == player
      end
    end

    SQUARES_ON_BOARD.each { |square| return square if square_unoccupied?(square) }
    return NO_MOVE
  end

  def create_new_game_for(square, player)
    Game.new(board, square, player)
  end

  def winner
    if board[0] != '-' && board[0] == board[1] &&
        board[1] == board[2]
      return board[0]
    end
    if board[3] != '-' && board[3] == board[4] &&
        board[4] == board[5]
      return board[3]
    end
    if board[6] != '-' && board[6] == board[7] &&
        board[7] == board[8]
      return board[6]
    end
    return '-'
  end

  def square_unoccupied?(square)
    board[square] == '-'
  end
end
