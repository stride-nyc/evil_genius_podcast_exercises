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
        move = square if winning_move?(square, player)
        move =  square if move == NO_MOVE
      end
    end

    return move
  end

  def winning_move?(square, player)
    game = Game.new(board, square, player)
    game.winner == player
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
