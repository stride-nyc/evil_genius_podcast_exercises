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
    if board[0,1] != '-' && board[0,1] == board[1,1] &&
        board[1,1] == board[2,1]
      return board[0,1]
    end
    if board[3,1] != '-' && board[3,1] == board[4,1] &&
        board[4,1] == board[5,1]
      return board[3,1]
    end
    if board[6,1] != '-' && board[6,1] == board[7,1] &&
        board[7,1] == board[8,1]
      return board[6,1]
    end
    return '-'
  end

  def square_unoccupied?(square)
    board[square,1] == '-'
  end
end
