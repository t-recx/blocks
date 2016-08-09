class Logic
  attr_reader :field
  attr_reader :milliseconds_to_next_step
  attr_reader :current_piece
  attr_reader :last_step_milliseconds
  attr_reader :running
  attr_reader :score
  attr_reader :level
  attr_reader :next_blockset

  INITIAL_MILLISECONDS_TO_NEXT_STEP = 1000
  MILLISECONDS_DOWN_PER_LEVEL = 40

  def initialize(input, timer, piece_factory, line_cleaner, scoring)
    @input = input
    @timer = timer
    @piece_factory = piece_factory
    @line_cleaner = line_cleaner
    @scoring = scoring

    @next_blockset = nil
    @field = []
    @field_width = 10
    @field_height = 20
    @last_step_milliseconds = 0
    @milliseconds_to_next_step = INITIAL_MILLISECONDS_TO_NEXT_STEP
    @running = true
    @score = 0
    @level = 0
    @total_lines_cleared = 0

    create_new_piece
  end

  def settle_piece_on_field
    @field += @current_piece.current_block.map {|i| [i[0] + @current_piece.x, i[1] + @current_piece.y] } if @current_piece
  end

  def clear_lines
    lines_cleared = @line_cleaner.clear_lines(@field, @field_width, @field_height)
  
    @total_lines_cleared += lines_cleared

    @level = @total_lines_cleared / 10
    
    @milliseconds_to_next_step = INITIAL_MILLISECONDS_TO_NEXT_STEP - MILLISECONDS_DOWN_PER_LEVEL * level
    
    @score += @scoring.evaluate_score(@level, lines_cleared)
  end

  def verify_endgame
    if @field.group_by {|i| i }.values.any? {|i| i.length > 1 } then
      @running = false
      return true
    end

    return false
  end

  def evaluate_game
    settle_piece_on_field
    
    return if verify_endgame

    clear_lines

    create_new_piece
  end

  def create_new_piece
    @current_piece = @piece_factory.get_new_piece(@field_width / 2, 0, @next_blockset) 
    
    @next_blockset = @piece_factory.get_new_blockset
    
    restart_step_counter
  end

  def update
    return if not @running

    @current_piece.rotate(@field, @field_width, @field_height) if @input.rotate

    @current_piece.move_left(@field) if @input.left
    @current_piece.move_right(@field, @field_width) if @input.right

    if @input.drop then
      @current_piece.drop(@field, @field_height)
      evaluate_game
    end
    
    if @input.down or (@timer.milliseconds - @last_step_milliseconds).abs > @milliseconds_to_next_step then
      if not @current_piece.move_down(@field, @field_height) then
        evaluate_game
      end

      restart_step_counter
    end
  end

  def restart_step_counter
    @last_step_milliseconds = @timer.milliseconds
  end
end
