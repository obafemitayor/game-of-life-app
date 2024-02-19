class GameOfLife
  def initialize(initial_state, rows, cols)
    validate_parameters(initial_state, rows, cols)
    
    initial_state = initial_state.nil? || initial_state.empty? ? [] : initial_state

    @rows = rows
    @cols = cols
    @initial_cells = nil

    if rows.nil? && cols.nil?
      @board = populate_dynamic_board(initial_state)
      @is_dynamic = true
    else
      @board = populate_fixed_board(initial_state)
    end

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
    alive_cells = []
  
    @rows.times do |row|
      @cols.times do |col|
        alive_neighbors = get_number_of_alive_neighbours(row, col)

        is_lonely = @board[row][col] == 1 && alive_neighbors < 2
        is_happy = @board[row][col] == 1 && alive_neighbors == 2 || alive_neighbors == 3
        is_overcrowded = @board[row][col] == 1 && alive_neighbors > 3
        can_have_new_life = @board[row][col] == 0 && alive_neighbors == 3

        new_board[row][col] = is_lonely ? 0 : is_happy ? 1 : is_overcrowded ? 0 : can_have_new_life ? 1 : 0

        new_board[row][col] == 1 ? alive_cells << [row, col] : nil
      end
    end
    
    if @is_dynamic
      @board = populate_dynamic_board(alive_cells)
      return
    end
    
    @board = new_board
  end

  private

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

  def populate_fixed_board(initial_state)
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

  def get_initial_cells(initial_state)
    board = Hash.new(false)
    initial_state.each do |cell|
      board[cell] = true
    end
    board
  end

  def get_board_boundaries()
    min_row_value = @initial_cells.keys.map { |cell| cell[0] }.min - 1
    max_row_value = @initial_cells.keys.map { |cell| cell[0] }.max + 1
    min_column_value = @initial_cells.keys.map { |cell| cell[1] }.min - 1
    max_column_value = @initial_cells.keys.map { |cell| cell[1] }.max + 1

    [min_column_value, max_column_value, min_row_value, max_row_value]
  end

  def populate_dynamic_board(initial_state)
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
