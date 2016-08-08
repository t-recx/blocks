require 'test/unit'
require './scoring.rb'

class TestScoring < Test::Unit::TestCase
  def setup
    @scoring = Scoring.new
  end

  def test_scoring
    score_testcase(0, 0, 0)
    score_testcase(0, 1, 40)
    score_testcase(2, 2, 300)
    score_testcase(1, 3, 600)
    score_testcase(0, 4, 1200)
  end

  def score_testcase(level, lines_cleared, expected_points)
    assert_equal expected_points, @scoring.evaluate_score(level, lines_cleared)
  end
end
