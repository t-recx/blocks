require 'test/unit'
require './piece.rb'

class TestPiece < Test::Unit::TestCase
  def setup
    @x, @y = 4, 1
    
    @block1 = [[-1, 0], [0, 0], [1, 0], [0, -1]] #    _|_
    @block2 = [[-1, 0], [0, 0], [0, -1], [0, 1]] # -|
    @block3 = [[-1, 0], [0, 0], [1, 0], [0, 1]]  #    "|"
    @block4 = [[1, 0], [0, 0], [0, 1], [0, -1]]  #  |-
    @blocks = [@block1, @block2, @block3, @block4]

    @field = []

    @field_width = 12
    @field_height = 16

    @piece = Piece.new(@x, @y, @blocks)
  end

  def rotate_piece(fh = @field_height)
    @piece.rotate(@field, @field_width, fh) 
  end

  def test_rotate_should_use_next_block
    @blocks.each do |block|
      assert_equal block, @piece.current_block

      rotate_piece
    end
  end

  def test_rotate_when_finished_should_restart_from_first_block
    @blocks.length.times do
      rotate_piece
    end

    assert_equal @block1, @piece.current_block
  end

  def test_rotate_should_not_rotate_when_rotation_would_put_block_out_of_bounds_leftwards
    rotate_piece until @piece.current_block.equal? @block4

    @piece.move_left(@field) until @piece.x.equal? 0

    rotate_piece

    assert_equal @block4, @piece.current_block
  end

  def test_rotate_should_not_rotate_when_rotation_would_put_block_out_of_bounds_rightwards
    rotate_piece until @piece.current_block.equal? @block2

    @piece.move_right(@field, @field_width) until @piece.x.equal? @field_width - 1

    rotate_piece

    assert_equal @block2, @piece.current_block
  end

  def test_rotate_should_not_rotate_when_rotation_would_put_block_out_of_bounds_downwards
    rotate_piece(@y)

    assert_equal @block1, @piece.current_block
  end

  def test_rotate_should_not_rotate_when_rotation_would_put_block_inside_field_blocks
    rotate_piece until @piece.current_block.equal? @block2

    @field = [[@x + 1, @y]]

    rotate_piece

    assert_equal @block2, @piece.current_block
  end

  def test_move_down_should_increase_y
    @piece.move_down(@field, @field_height)

    assert_equal @y+1, @piece.y
  end

  def test_move_down_should_not_increase_y_if_move_gets_piece_out_of_bounds
    @piece.move_down(@field, @y)

    assert_equal @y, @piece.y
  end

  def test_move_down_should_not_increase_y_if_field_occupied
    @field = [[@x, @y + 1]]

    @piece.move_down(@field, @field_height)

    assert_equal @y, @piece.y
  end

  def test_move_left_should_decrease_x
    @x.downto(1) do |i|
      assert_equal i, @piece.x

      @piece.move_left(@field)
    end
  end

  def test_move_left_should_not_decrease_x_if_any_block_outside_field
    @x.times do 
      @piece.move_left(@field)
    end

    assert_equal 1, @piece.x
  end

  def test_move_left_should_not_decrease_x_if_any_field_block_blocking_way
    [[2, 1], [3, 0]].each do |tc|
      @field = [tc]
      
      @piece.move_left(@field)

      assert_equal @x, @piece.x
    end
  end

  def test_move_right_should_increase_x
    @x.upto(10) do |i|
      assert_equal i, @piece.x

      @piece.move_right(@field, @field_width)
    end
  end

  def test_move_right_should_not_increase_x_if_any_block_out_of_bounds
    @piece.move_right(@field, @x + 1)

    assert_equal @x, @piece.x
  end

  def test_move_right_should_not_increase_x_if_any_field_block_blocking_way
    [[6, 1], [5, 0]].each do |tc|
      @field = [tc]
      
      @piece.move_right(@field, @field_width)

      assert_equal @x, @piece.x
    end
  end

  def test_drop_should_increase_y_until_end_field
    @piece.drop(@field, @field_height)

    assert_equal @field_height - 1, @piece.y
  end
end
