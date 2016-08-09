require 'test/unit'
require './logic.rb'
require './piece.rb'
require './piece_factory.rb'
require './fakes.rb'

class TestLogic < Test::Unit::TestCase
  def setup
    @fake_milliseconds = 293932
    
    @fake_input = FakeInput.new
    @fake_timer = FakeTimer.new
    @fake_line_cleaner = FakeLineCleaner.new
    @fake_scoring = FakeScoring.new

    @fake_piece = FakePiece.new

    @fake_piece_factory = FakePieceFactory.new(@fake_piece)

    @fake_timer.milliseconds = @fake_milliseconds

    @logic = Logic.new(@fake_input, @fake_timer, @fake_piece_factory, @fake_line_cleaner, @fake_scoring)
  end

  def test_update_when_down_should_set_last_step_milliseconds
    @fake_input.down = 1

    @logic.update

    assert_equal @fake_milliseconds, @logic.last_step_milliseconds
  end

  def test_update_when_drop_should_set_last_step_milliseconds
    @fake_input.drop = 1

    @logic.update

    assert_equal @fake_milliseconds, @logic.last_step_milliseconds
  end 

  def test_update_when_input_down_should_move_piece_down
    @fake_input.down = 1

    @logic.update

    assert_equal true, @fake_piece.down_called
  end

  def test_update_when_input_left_should_move_piece_left
    @fake_input.left = 1

    @logic.update

    assert_equal true, @fake_piece.left_called
  end

  def test_update_when_input_right_should_move_piece_right
    @fake_input.right = 1

    @logic.update

    assert_equal true, @fake_piece.right_called
  end

  def test_update_when_input_drop_should_drop_piece
    @fake_input.drop = 1

    @logic.update

    assert_equal true, @fake_piece.drop_called
  end

  def test_update_when_input_rotate_should_rotate_piece
    @fake_input.rotate = 1
  
    @logic.update

    assert_equal true, @fake_piece.rotate_called
  end

  def test_update_when_sufficient_time_has_passed_should_move_piece_down_a_step
    @fake_timer.milliseconds = @fake_milliseconds + @logic.milliseconds_to_next_step 

    @logic.update

    assert_equal false, @fake_piece.down_called

    @fake_timer.milliseconds += 1

    @logic.update

    assert_equal true, @fake_piece.down_called
  end

  def test_update_when_move_down_doesnt_move_piece_should_create_new_piece_should_incorporate_block_into_field
    @fake_input.down = 1

    @fake_piece.down_return_value = false

    @fake_piece.x = 2
    @fake_piece.y = 3
    @fake_piece.current_block = [[1, 1], [1, 2]]

    @fake_piece_factory.get_new_piece_times_called = 0

    @logic.update

    assert_equal 1, @fake_piece_factory.get_new_piece_times_called
    assert_equal [[3, 4], [3, 5]], @logic.field

    @fake_piece.x = 5
    @fake_piece.y = 6
    @fake_piece.current_block = [[0,0], [1, 0], [2, 2]]

    @logic.update 

    assert_equal [[3, 4], [3, 5], [5, 6], [6, 6], [7, 8]], @logic.field 
    assert_equal true, @logic.running
  end

  def test_update_when_piece_settles_should_call_line_cleaner
    @fake_input.down = 1

    @fake_piece.down_return_value = false

    @logic.update

    assert_equal true, @fake_line_cleaner.clear_lines_called
    assert_equal true, @fake_scoring.evaluate_score_called
  end

  def test_scoring
    @fake_input.down = 1

    @fake_piece.down_return_value = false

    @fake_scoring.points = 100

    @logic.update

    assert_equal true, @fake_scoring.evaluate_score_called
    assert_equal 100, @logic.score
  end
end

