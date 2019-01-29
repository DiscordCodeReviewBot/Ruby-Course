import sys

class SudokuSolver:

    def __init__(self, board):
        self.board = board
        self.current_coords = (0, 0)

    def add_to_board(self, column, row, number):
        self.board[column][row] = number

    def print_board(self):
        print("\n")
        print("               BOARD             ")
        print("   ", end="")
        for i in range(9):
            print(" " + str(i) + " ", end="")
            if i % 3 == 2:
                print(" ", end="")
        print("\n  -------------------------------")
        for i in range(9):
            print(str(i) + " ", end="")
            print("|", end="")
            for j in range(9):
                print(" " + str(self.board[i][j])+" ", end="")
                if j % 3 == 2:
                    print("|", end="")
            if i % 3 == 2:
                print("\n  -------------------------------", end="")
            print()

    def print_without_effects(self):
        for i in self.board:
            print(i)

    def used_in_row(self, row, number):
        for col in range(9):
            if str(self.board[row][col]) == str(number):
                return True
        return False

    def used_in_col(self, col, number):
        for row in range(9):
            if str(self.board[row][col]) == str(number):
                return True
        return False

    def used_in_box(self, box_start_row, box_start_col, number):
        for row in range(3):
            for col in range(3):
                if str(self.board[row + box_start_row][col + box_start_col]) == str(number):
                    return True
        return False

    def is_safe(self, row, col, number):
        return not self.used_in_row(row, number)\
                                    and not self.used_in_col(col, number) \
                                    and not self.used_in_box(row - row % 3, col - col % 3, number)

    def find_next_not_aasigned(self):
        for i in range(9):
            for j in range(9):
                if self.board[i][j] == "":
                    return i, j
        return False

    def solve(self):
        if self.find_next_not_aasigned() is False:
            return True

        x_y_pair = self.find_next_not_aasigned()

        for number in range(1, 10):
            if self.is_safe(x_y_pair[0], x_y_pair[1], number) is True:
                self.board[x_y_pair[0]][x_y_pair[1]] = number
                if self.solve() is True:
                    return True
                self.board[x_y_pair[0]][x_y_pair[1]] = ""
        return False

if __name__ == "__main__":
    f = open("boardinfo.txt","r")
    f2 = open("boardresult.txt","w+")
    board = eval(f.read())
    solver = SudokuSolver(board)
    solver.solve()
    f2.write(str(board))












