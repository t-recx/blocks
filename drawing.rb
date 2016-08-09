require 'gosu'

class Drawing
  def initialize(window_width, window_height)
    @window_width, @window_height = window_width, window_height

    @block_image = Gosu::Image.new('media/block.png')

    @font = Gosu::Font.new(16)
  end

  def draw(logic)
    draw_field(logic)
    draw_current_piece(logic.current_piece)
    draw_next_piece(logic.next_blockset)
    draw_text(logic)
  end

  def draw_text(logic)
    @font.draw("Score: #{logic.score}", 170, 4, 0)
    @font.draw("Level: #{logic.level}", 170, 24, 0)
    @font.draw("Next: ", 170, 44, 0)

    @font.draw_rel("Game Over!", 170 + (@window_width - 170) / 2, @window_height - 20, 0, 0.5, 0.5, 1, 1, 0xff_ff0000) if not logic.running 
  end

  def draw_field(logic)
    logic.field.each do |f|
      @block_image.draw(screen_x(f[0]), screen_y(f[1]), 0)
    end
  end

  def draw_current_piece(piece)
    piece.current_block.each do |b|
      @block_image.draw(screen_x(piece.x + b[0]), screen_y(piece.y + b[1]), 0)
    end
  end

  def draw_next_piece(blockset)
    return unless blockset

    blockset.first.each do |b|
      @block_image.draw(200 + screen_x(b[0]), 80 + screen_y(b[1]), 0)
    end
  end

  def screen_x(x)
    x * @block_image.width
  end

  def screen_y(y)
    y * @block_image.height
  end
end
