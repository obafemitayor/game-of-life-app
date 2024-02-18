class GameOfLife
    def initialize(rows, cols, initial_state)
      initial_state = initial_state.nil? || initial_state.empty? ? [] : initial_state
      if rows < 0 || cols < 0
        raise ArgumentError, 'The number of rows and columns must be greater than 0'
      end
      @rows = rows
      @cols = cols
      @board = Array.new(rows) { Array.new(cols, 0) }
      populate_board(initial_state)
    end
    
    def display_board
      @board.each do |row|
        row.each do |cell|
          print cell == 1 ? 'x ' : 'o '
        end
        puts
      end
      puts
    end
  
    def get_board_next_state
      new_board = Array.new(@rows) { Array.new(@cols, 0) }
    
      @rows.times do |row|
        @cols.times do |col|
          alive_neighbors = get_number_of_alive_neighbours(row, col)
  
          is_lonely = @board[row][col] == 1 && alive_neighbors < 2
          is_happy = @board[row][col] == 1 && alive_neighbors == 2 || alive_neighbors == 3
          is_overcrowded = @board[row][col] == 1 && alive_neighbors > 3
          can_have_new_life = @board[row][col] == 0 && alive_neighbors == 3
  
          new_board[row][col] = is_lonely ? 0 : is_happy ? 1 : is_overcrowded ? 0 : can_have_new_life ? 1 : 0
        end
      end
      
      @board = new_board
    end
  
    private
  
    def get_cell_neighbours(row, col)
      top = row > 0 ? @board[row - 1][col] : nil
      bottom = row < @rows - 1 ? @board[row + 1][col] : nil
      left = col > 0 ? @board[row][col - 1] : nil
      right = col < @cols - 1 ? @board[row][col + 1] : nil
      top_left = row > 0 && col > 0 ? @board[row - 1][col - 1] : nil
      top_right = row > 0 && col < @cols - 1 ? @board[row - 1][col + 1] : nil
      bottom_left = row < @rows - 1 && col > 0 ? @board[row + 1][col - 1] : nil
      bottom_right = row < @rows - 1 && col < @cols - 1 ? @board[row + 1][col + 1] : nil
        
      [top, bottom, left, right, top_left, top_right, bottom_left, bottom_right]
    end
  
    def get_number_of_alive_neighbours(row, col)
      cell_neighbours = get_cell_neighbours(row, col)
      alive_neighbors = cell_neighbours.count(1)
    end

    def populate_board(initial_state)
        initial_state.each do |row, col|
            if row >= 0 && row < @rows && col >= 0 && col < @cols
              @board[row][col] = 1
            else
              raise ArgumentError, 'Initial state must fall within the board dimensions'
            end
        end
    end

  end
  