class Game
  attr_accessor :board

  NO_MOVE = -1

  def initialize(s, position=nil, player=nil)
    @board = s.dup
    @board[position] = player unless position == nil
  end

  def best_move_for(player)
    (0..8).each do |move|
      if square_unoccupied?(move)
        game = play(move, player)
        return move if game.winner() == player
      end
    end

    (0..8).each { |move| return move if square_unoccupied?(move) }
    return NO_MOVE
  end

  def play(move, player)
    Game.new(board, move, player)
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
