# Helper Method
def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
  end
  
  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8], # Top Left to bottom right diagonal
    [2, 4, 6]  # Top right to bottom left diagonal
  ]
  
  board = [" "," "," "," "," "," "," "," "," "]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      if board[combo[0]] == board[combo[1]] &&
        board[combo[1]] == board[combo[2]] 
        position_taken?(board, combo[0])
      end
    end
  end
  
  def full?(board)
    board.all?{|token| token == "X" || token == "O"}
  end
  
  def draw?(board)
    full?(board) && !won?(board)
  end
  
  def over?(board)
    won?(board) || draw?(board)
  end
  
  def winner(board)
    if winning_combo = won?(board)
      board[winning_combo[0]]
    end
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board, index, current_player)
    board[index] = current_player
  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  def turn_count(board)
    count = 0
    board.each do |player|
     if player == "X" || player == "O"
      count += 1
     end
    end
    count
  end

  def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end


def turn(board)
    puts 'Please enter 1-9:'
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def play(board)
    turn(board) until over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
