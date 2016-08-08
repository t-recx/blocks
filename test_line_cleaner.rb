require 'test/unit'
require './line_cleaner.rb'

class TestLineCleaner < Test::Unit::TestCase
  def setup
    @line_cleaner = LineCleaner.new
  end

  def test_clear_lines_should_clear_line_when_row_complete
    @field = [[0,3], [1, 3], [2, 3]]

    lines_cleared = @line_cleaner.clear_lines(@field, 3, 3)

    assert_equal 0, @field.length

    assert_equal 1, lines_cleared
  end

  def test_clear_lines_if_row_not_complete_should_not_alter_array
    @field = [[0, 3], [2, 3]]

    lines_cleared = @line_cleaner.clear_lines(@field, 3, 3)

    assert_equal [[0, 3], [2, 3]], @field

    assert_equal 0, lines_cleared
  end

  def test_clear_lines_should_push_lines_down_after_deleting
    @field = [[0, 1], [1, 2], [0, 3], [1, 3]]

    @line_cleaner.clear_lines(@field, 2, 4)

    assert_equal [[0, 2], [1, 3]], @field
  end
end
