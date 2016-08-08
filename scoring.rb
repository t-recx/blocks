class Scoring
  def evaluate_score(level, lines_cleared)
    # NES / GB / SNES scoring system

    return (level + 1) * 40 if lines_cleared.equal? 1
    return (level + 1) * 100 if lines_cleared.equal? 2
    return (level + 1) * 300 if lines_cleared.equal? 3
    return (level + 1) * 1200 if lines_cleared.equal? 4

    return 0
  end
end
