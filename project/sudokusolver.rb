class SudokuSolver
  attr_reader :board
  def initialize
    @board = Array.new(9) { Array.new(9,"-")}
    @current_cords = [0,0]
  end

  def add_to_board(column, row, number)
    @board[column][row] = number
  end

  def used_in_row(row, number)
    for col in 0...9
      if @board[row][col].to_s == number.to_s
          return true
      end
    end
    return false
  end

  def used_in_col(col, number)
    for row in 0...9
      if @board[row][col].to_s == number.to_s
        return true
      end
    end
    return false
  end

  def used_in_box(box_start_row, box_start_col, number)
      for row in 0...3
        for col in 0...3
          if @board[row + box_start_row][col + box_start_col].to_s == number.to_s
              return true
          end
        end
      end
      return false
  end

  def is_safe(row, col, number)
    return (not used_in_row(row, number) and not used_in_col(col, number) and not used_in_box(row - row % 3, col - col % 3, number))
  end

  def find_next_not_aasigned
      for i in 0...9
        for j in 0...9
          if @board[i][j] == "-"
            return [i, j]
          else
            return "not found"
          end
        end
      end
  end

  def solve
    if find_next_not_aasigned == "not found"
      return "koniec"
    end

    x_y_pair = find_next_not_aasigned

    for number in 1...10
      if is_safe(x_y_pair[0], [x_y_pair], number)
        puts(@board)
        puts
        @board[x_y_pair[0],x_y_pair[1]] = number
        if is_safe == "koniec"
          return true
        end
        @board[x_y_pair[0]][x_y_pair[1]] = "-"
      end
    end
  end
end

#a = SudokuSolver.new
#print(a.board)
#puts
#print(a.is_safe(0,0,1))