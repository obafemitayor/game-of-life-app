require 'minitest/autorun'
require_relative '../game_of_life'

class GameOfLifeTest < MiniTest::Test

  def test_initialize_with_empty_state
    @initial_state = nil
    @game = GameOfLife.new(@initial_state, 3, 3)
    expected_next_generation = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    @initial_state = []
    @game = GameOfLife.new(@initial_state, 3, 3)
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_initialize_with_negative_rows_or_columns
    assert_raises ArgumentError, 'The number of rows and columns must be greater than 0' do
      GameOfLife.new([], -1, 3)
    end

    assert_raises ArgumentError, 'The number of rows and columns must be greater than 0' do
      GameOfLife.new([], 3, -1)
    end
  end

  def test_initialize_with_invalid_initial_state
    assert_raises ArgumentError, 'Initial state must fall within the board dimensions' do
      GameOfLife.new([[0,1], [5,1], [2,1]], 3, 3)
    end

    assert_raises ArgumentError, 'Initial state must fall within the board dimensions' do
      GameOfLife.new([[0,1], [1,1], [2,6]], 3, 3)
    end
  end

  def test_blinker_pattern_with_two_generations
    @initial_state = [[0,1], [1,1], [2,1]]
    @game = GameOfLife.new(@initial_state, 3, 3)
    expected_next_generation = [
        [0, 0, 0],
        [1, 1, 1],
        [0, 0, 0]
      ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    expected_next_generation = [
        [0, 1, 0],
        [0, 1, 0],
        [0, 1, 0]
        ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_block_pattern_with_two_generations
    @initial_state = [[1,2], [1,3], [2,2], [2,3]]
    @game = GameOfLife.new(@initial_state, 5, 5)
    expected_next_generation = [
        [0, 0, 0, 0, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
        ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_initialize_with_invalid_arguments
    assert_raises ArgumentError, 'Initial state or board dimensions must be provided' do
      GameOfLife.new(nil, nil, nil)
    end
  end

  def test_initialize_with_row_and_no_columns
    assert_raises ArgumentError, 'Both rows and columns must be provided' do
      GameOfLife.new(nil, 1, nil)
    end
  end

  def test_initialize_with_column_and_no_rows
    assert_raises ArgumentError, 'Both rows and columns must be provided' do
      GameOfLife.new(nil, nil, 1)
    end
  end

  def test_glider_pattern
    @initial_state = [[1,2], [2,3], [3,1], [3,2], [3,3]]
    @game = GameOfLife.new(@initial_state, nil, nil)
    expected_next_generation = [
        [0, 0, 0, 0, 0],
        [0, 1, 0, 1, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_glider_pattern_with_two_generations
    @initial_state = [[1,2], [2,3], [3,1], [3,2], [3,3]]
    @game = GameOfLife.new(@initial_state, nil, nil)
    expected_next_generation = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0],
        [0, 1, 0, 1, 0],
        [0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0]
      ]
    @game.get_board_next_state
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_glider_pattern_with_three_generations
    @initial_state = [[1,2], [2,3], [3,1], [3,2], [3,3]]
    @game = GameOfLife.new(@initial_state, nil, nil)
    expected_next_generation = [
        [0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0],
        [0, 0, 1, 1, 0],
        [0, 1, 1, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    @game.get_board_next_state
    @game.get_board_next_state
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_blinker_pattern_with_dynamic_board_three_generations
    @initial_state = [[0,1], [1,1], [2,1]]
    @game = GameOfLife.new(@initial_state, nil, nil)
    expected_next_generation = [
        [0, 0, 0, 0, 0],
        [0, 1, 1, 1, 0],
        [0, 0, 0, 0, 0]
      ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    expected_next_generation = [
      [0, 0, 0],
      [0, 1, 0],
      [0, 1, 0],
      [0, 1, 0],
      [0, 0, 0]
    ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    expected_next_generation = [
      [0, 0, 0, 0, 0],
      [0, 1, 1, 1, 0],
      [0, 0, 0, 0, 0]
    ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_block_pattern_with_dynamic_board
    @initial_state = [[1,2], [1,3], [2,2], [2,3]]
    @game = GameOfLife.new(@initial_state, nil, nil)
    expected_next_generation = [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0]
        ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

end
