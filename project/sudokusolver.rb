class SudokuSolver

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
          true
      else
       false
      end
    end
  end

  def used_in_col(col, number)
    for row in 0...9
      if @board[row][col].to_s == number.to_s
        true
      else
        false
      end
    end
  end

  def used_in_box(box_start_row, box_start_col, number)
      for row in 0...3
        for col in 0...3
          if @board[row + box_start_row][col + box_start_col].to_s == number.to_s
              true
          else
            false
          end
        end
      end
  end

  def is_safe(row, col, number)
    not used_in_row(row, number) and not used_in_col(col, number) and not used_in_box(row - row % 3, col - col % 3, number)
  end

  def find_next_not_aasigned
      for i in 0...9
        for j in 0...9
          if @board[i][j] == "-"
               [i, j]
          else
            false
          end
        end
      end
  end

  def solve
    if find_next_not_aasigned == false
      true
    end

    x_y_pair = find_next_not_aasigned

   for number in 1...10
      if is_safe(x_y_pair[0], x_y_pair[1], number) == true
        @board[x_y_pair[0]][x_y_pair[1]] = number
      end
      if solve == true
        true
      end
      @board[x_y_pair[0]][x_y_pair[1]] = "-"
      false
    end
  end
end

