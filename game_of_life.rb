class GameOfLife
  def initialize(initial_state, rows, cols)
    validate_parameters(initial_state, rows, cols)

    initial_state = initial_state.nil? || initial_state.empty? ? [] : initial_state

    @rows = rows
    @cols = cols

    @board = rows.nil? && cols.nil? ? build_dynamic_game_board(initial_state) : build_fixed_game_board(initial_state)

  end
  
  # Method to display the board on the console
  def display_board
    @board.each do |row|
      row.each do |cell|
        print cell == 1 ? 'x ' : 'o '
      end
      puts
    end
    puts
  end

  # Method to get the next state of the board
  def get_board_next_state
    @board = rebuild_board_with_new_values
  end

  private

  # Method to rebuild the board with new values
  # If the board is dynamic, we keep track of all the alive cells after implementing the rules of the game
  # and then rebuild the dynamic board with the alive cells
  def rebuild_board_with_new_values
    game_board = Array.new(@rows) { Array.new(@cols, 0) }
    alive_cells = []
  
    @rows.times do |row|
      @cols.times do |col|
        game_board[row][col] = get_new_value_of_cell(row, col)
        game_board[row][col] == 1 ? alive_cells << [row, col] : nil
      end
    end

    board = @is_dynamic ? build_dynamic_game_board(alive_cells) : game_board

    board
  end

  # Method to get the new value of a cell based on conway's game of life rules
  def get_new_value_of_cell(row, col)
    alive_neighbors = get_number_of_alive_cell_neighbours(row, col)
    
    case @board[row][col]
    when 1
      return 0 if alive_neighbors < 2 # Lonely
      return 1 if alive_neighbors == 2 || alive_neighbors == 3 # Happy
      return 0 if alive_neighbors > 3 # Overcrowded
    when 0
      return 1 if alive_neighbors == 3 # New life
    end
  
    0
  end
  

  # Method to validate the input parameters
  def validate_parameters(initial_state, rows, cols)
    if initial_state.nil? && (rows.nil? || cols.nil?)
      raise ArgumentError, 'Initial state or board dimensions must be provided'
    end

    if (rows && rows < 0) || (cols && cols < 0)
      raise ArgumentError, 'The number of rows and columns must be greater than 0'
    end

    if rows && cols.nil? || cols && rows.nil?
      raise ArgumentError, 'Both rows and columns must be provided'
    end
  end
    
  # Method to get the number of alive neighbours of a cell
  def get_number_of_alive_cell_neighbours(row, col)
    alive_neighbors = 0
    alive_neighbors = row > 0 && @board[row - 1][col] === 1 ? alive_neighbors + 1 : alive_neighbors # check if top neighbor is alive
    alive_neighbors = row < @rows - 1 && @board[row + 1][col] === 1 ? alive_neighbors + 1 : alive_neighbors # check if bottom neighbor is alive
    alive_neighbors = col > 0 && @board[row][col - 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if left neighbor is alive
    alive_neighbors = col < @cols - 1 && @board[row][col + 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if right neighbor is alive
    alive_neighbors = row > 0 && col > 0 && @board[row - 1][col - 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if top left neighbor is alive
    alive_neighbors = row > 0 && col < @cols - 1 && @board[row - 1][col + 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if top right neighbor is alive
    alive_neighbors = row < @rows - 1 && col > 0 && @board[row + 1][col - 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if bottom left neighbor is alive
    alive_neighbors = row < @rows - 1 && col < @cols - 1 && @board[row + 1][col + 1] === 1 ? alive_neighbors + 1 : alive_neighbors # check if bottom right neighbor is alive
    
    alive_neighbors
  end

  # Method to build a fixed game board
  def build_fixed_game_board(initial_state)
      board_array = Array.new(@rows) { Array.new(@cols, 0) }
      initial_state.each do |row, col|
          if row >= 0 && row < @rows && col >= 0 && col < @cols
            board_array[row][col] = 1
          else
            raise ArgumentError, 'Initial state must fall within the board dimensions'
          end
      end
      board_array
  end

  # Method for returning a hash table that contains the initial state of the cells
  def get_initial_cells(initial_state)
    board = Hash.new(false)
    initial_state.each do |cell|
      board[cell] = true
    end
    board
  end

  # Method to get the boundaries of a dynamic board based on the positions of the initial state
  def get_board_boundaries()
    min_row_value = @initial_cells.keys.map { |cell| cell[0] }.min - 1
    max_row_value = @initial_cells.keys.map { |cell| cell[0] }.max + 1
    min_column_value = @initial_cells.keys.map { |cell| cell[1] }.min - 1
    max_column_value = @initial_cells.keys.map { |cell| cell[1] }.max + 1

    [min_column_value, max_column_value, min_row_value, max_row_value]
  end

  # Method to build a dynamic game board
  # First use a hash table to store the initial state of the cells
  # then get the boundaries of the board based on the positions of the initial state
  # finally, iterate through the range of the boundaries (i.e  from the minimum row to the maximum row and from the minimum column to the maximum column) 
  # and then build the board array with the initial state
  def build_dynamic_game_board(initial_state)
    @is_dynamic = true
    @initial_cells = get_initial_cells(initial_state)
    min_column_value, max_column_value, min_row_value, max_row_value = get_board_boundaries
    board_array = []
  
    (min_row_value..max_row_value).each do |row|
      row_array = []
      (min_column_value..max_column_value).each do |column|
        row_array << (@initial_cells[[row, column]] ? 1 : 0)
      end
      board_array << row_array
    end

    @rows = board_array.length
    @cols = board_array[0].length

    board_array
  end
  
  

end
