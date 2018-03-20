Next Steps
- encapsulate each if block from #winner in its own method
- change #winning_move? so that we no longer have to instantiate
a new game just to modify the existing game board
- introduce objects!

Notes
Method #best_move_for
  for each square, we:
  - see if that square is unoccupied
  - if so, we add letter to that square on the board
  - then, we examine the board and look for a winner
  - if there is a row where all three squares have Xs,
    we return an X. if there is a row where all three
    squares have Os, we return a O.
  - Now, if we get through all the squares and we haven't
    returned a "winner", then we go through the array and return
    the first unoccupied square.
  - If we still haven't returned anything by this point, we
    return a -1, which means no move can be made.

Test smells
1. Architecture and naming
  We have a single object, Game. Game is initialized with a string that represents the board.
    Formatting is good and easy to read, but WHY do you have to initialize a new game every for every move?! Game.new acts more like Turn.new
  A game has two instance methods that we know of, Method #move and #winner.
  Method #move takes an 'X' or an 'O' and returns an integer. This integer represents the position on the board where the letter will go.
  If the board is full, Method #move returns a -1.
  The tests do not make it clear if Method #move has the side effect of
  adding the letter to the board, or if Method #move delegates that
  responsibility to another method.
2. Incomplete test cases
  Method #test_find_winning_move tells you that #move has to be
    smart enough to find the more strategic space on the board
    to fill in IF there's more than one space open, but the board
    passed to Game has 4 Xs and 3 Os and tries to move with X,
    so instead of returning 5 this method should actually return
    some kind of error -- "Not X's turn! Calm down X."
    Method #test_find_winning_move makes a normal call to #move and
    returns 5. How are you supposed to know this is a winning move?
    There's no feedback, like a print statement 'Player X wins!'
    I guess you have to call Method #winner on the game to figure out who
    the winner is? But do you call winner after every move?
    What tells you that the game is over?
  Method #test_win_conditions tests that calling the method #winner
    will return an 'X' when there are 3 Xs in a row on the board

Implementation Smells
1. Initialize with an argument called 's'. WTF is 's'?
2. From reading the tests first, I had no idea that initialize
    had optional arguments, position and player, that default to nil
3. (0..8) is a bald-ass range that Method #move iterates over.
    This range is devoid of meaning. Why not assign it to a constant,
    like SQUARES or POSITIONS?
4. Method #move has A LOT going on. As it's iterating over each square in the
    TTT board, if it finds a square that is empty, it will
    - create a new game with the board string, the empty position
      on the board, and the player
    - so yes, an instance method on Game creates a new game instance
      for no other reason than to put the new 'X' or 'O' on the board
      BUT the placement of the 'X' or 'O' isn't a real move -- we just
      put the letter there in order to determine if that placement will
      make the player a winner
    Method #move has way too much happening. should be broken up into at least
