# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Middle column
  [2,5,8], # Last column
  [0,4,8], # Left diagonal
  [2,4,6]  # Right diagonal
]

# Define display_board that accepts a board and prints out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# The #input_to_index method will take the user's input ("1"-"9") and
# convert it to the index of the board array (0-8).
def input_to_index(input)
  input = input.to_i - 1
end

# The #move method takes in three arguments; (1) board array, (2) index in the
# board array they player wants to fill and (3) player's character ("X" or "O")
def move(board, input, value)
  board[input] = value
end

# The #position_taken? method will evaluate player selected position against Tic
# Tac Toe board and checks whether or not the index on board array is occupied.
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

# The #valid_move? method accepts a board and an index to check and returns true
# if the move is valid and false or nil if not.
def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    return true
  end
end

#
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

# Method that tracks turns played
def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
    return turn
end

# The #current_player method sets #turn_count method to 'turn' to determine if
# it is "X" or "O" turns and returns "X" if turn is even index or "O" for odd index
def current_player(board)
  turn = turn_count(board)
    turn = turn.even? ? "X" : "O"
end

#
def won?(board)
  WIN_COMBINATIONS.each do | index |  # iterate over WIN_COMBINATIONS collection to return value #index array
    if index.all? { |i| board[i] == "X" }  # iterate through each element of each WIN_COMBINATIONS array and return array's (#index) with #all? "X"
      return index  # return the 3 element array (#index) with "X" representing the winning combination
    elsif index.all? { |i| board[i] == "O"}  # iterate through each element of each WIN_COMBINATIONS array and return array's (#index) with #all? "O"
      return index  # return the 3 element array (#index) with "O" representing the winning combination
    end
  end
    false # return false when 3 element array (#index) does not represent winning combination
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if (!full?(board) || draw?(board)) && !won?(board)
    return nil
  elsif (board[won?(board)[0]] == "X")
    return "X"
  elsif (board[won?(board)[0]] == "O")
    return "O"
  end
end

#
def play(board)
  until over?(board)
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end
