class FakeScoring
  attr_reader :evaluate_score_called
  attr_accessor :points

  def initialize
    @evaluate_score_called = false
    @points = 0
  end

  def evaluate_score(level, lines_cleared)
    @evaluate_score_called = true

    @points
  end
end

class FakeLineCleaner
  attr_accessor :clear_lines_called
  attr_accessor :lines_cleared

  def initialize
    @clear_lines_called = false

    @lines_cleared = 0
  end

  def clear_lines(field, field_width, field_height)
    @clear_lines_called = true

    @lines_cleared
  end
end

class FakeInput
  attr_accessor :rotate, :down, :left, :right, :start, :exit, :drop
end

class FakeTimer
  attr_accessor :milliseconds
end

class FakePieceFactory
  attr_accessor :get_new_piece_times_called

  def initialize(piece)
    @piece = piece
    @get_new_piece_times_called = 0
  end

  def get_new_blockset
  end

  def get_new_piece(x, y, blocks)
    @get_new_piece_times_called += 1

    @piece
  end
end

class FakePiece
  attr_reader :down_called
  attr_reader :left_called
  attr_reader :right_called
  attr_reader :drop_called
  attr_reader :rotate_called
  attr_accessor :down_return_value
  attr_accessor :current_block
  attr_accessor :x
  attr_accessor :y

  def initialize
    @down_called = false
    @left_called = false
    @right_called = false
    @drop_called = false
    @rotate_called = false
    @down_return_value = true
    @current_block = []
  end

  def rotate(field, field_width, field_height)
    @rotate_called = true
  end

  def drop(field, field_height)
    @drop_called = true
  end

  def move_down(field, field_height)
    @down_called = true

    return @down_return_value
  end

  def move_left(field)
    @left_called = true
  end

  def move_right(field, field_width)
    @right_called = true
  end
end
