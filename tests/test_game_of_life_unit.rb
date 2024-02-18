require 'minitest/autorun'
require_relative '../game_of_life'

class GameOfLifeTest < MiniTest::Test

  def test_initialize_with_empty_state
    @initial_state = nil
    @game = GameOfLife.new(3, 3, @initial_state)
    expected_next_generation = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
    @initial_state = []
    @game = GameOfLife.new(3, 3, @initial_state)
    @game.get_board_next_state
    assert_equal expected_next_generation, @game.instance_variable_get(:@board)
  end

  def test_initialize_with_negative_rows_or_columns
    assert_raises ArgumentError, 'The number of rows and columns must be greater than 0' do
      GameOfLife.new(-1, 3, [])
    end

    assert_raises ArgumentError, 'The number of rows and columns must be greater than 0' do
      GameOfLife.new(3, -1, [])
    end
  end

  def test_initialize_with_invalid_initial_state
    assert_raises ArgumentError, 'Initial state must fall within the board dimensions' do
      GameOfLife.new(3, 3, [[0,1], [5,1], [2,1]])
    end

    assert_raises ArgumentError, 'Initial state must fall within the board dimensions' do
      GameOfLife.new(3, 3, [[0,1], [1,1], [2,6]])
    end
  end

  def test_blinker_pattern_with_two_generations
    @initial_state = [[0,1], [1,1], [2,1]]
    @game = GameOfLife.new(3, 3, @initial_state)
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
    @game = GameOfLife.new(5, 5, @initial_state)
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
end
