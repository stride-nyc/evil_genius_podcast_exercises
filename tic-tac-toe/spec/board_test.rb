require 'test/unit'
require_relative '../lib/board'

class BoardTest < Test::Unit::TestCase
  def test_default_move
    board = Board.new("XOX" +
                    "OX-" +
                    "OXO")
    assert_equal(5, board.best_move_for('X'))

    board = Board.new("XOX" +
                    "OXO" +
                    "OX-")
    assert_equal(8, board.best_move_for('O'))

    board = Board.new("---" +
                    "---" +
                    "---")
    assert_equal(0, board.best_move_for('X'))

    board = Board.new("XXX" +
                    "XXX" +
                    "XXX")
    assert_equal(-1, board.best_move_for('X'))
  end

  def test_find_winning_move
    board = Board.new("XO-" +
                    "XX-" +
                    "OOX")
    assert_equal(5, board.best_move_for('X'))
  end

  def test_win_horizontal_conditions
    board = Board.new("---" +
                    "XXX" +
                    "---")
    assert_equal('X', board.winner())
  end

  def test_win_vertical_conditions
    board = Board.new("--O" +
                    "--O" +
                    "--O")
    assert_equal('O', board.winner())
  end

  def test_win_left_diagonal_conditions
    board = Board.new("X--" +
                    "-X-" +
                    "--X")
    assert_equal('X', board.winner())
  end

   def test_win_right_diagonal_conditions
    board = Board.new("--O" +
                    "-O-" +
                    "O--")
    assert_equal('O', board.winner())
  end
end
