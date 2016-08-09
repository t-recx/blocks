require 'gosu'
require './logic.rb'
require './piece_factory.rb'
require './input.rb'
require './line_cleaner.rb'
require './scoring.rb'
require './drawing.rb'

class GameWindow < Gosu::Window
  HIGHSCORE_FILENAME = 'highscores.dat'

  def initialize
    super 260, 320
    self.caption = "Blocks"

    @on_menu = true

    @menu_font = Gosu::Font.new(32)

    @highscore_font = Gosu::Font.new(16)

    @input = Input.new(200)
    @drawing = Drawing.new(width, height)

    load_highscore

    create_logic
  end

  def load_highscore
    @highscore = 0

    if File.exists? HIGHSCORE_FILENAME
      lines = File.readlines(HIGHSCORE_FILENAME)

      @highscore = lines.first.to_i if lines.length > 0
    end
  end

  def save_highscore
    File.open(HIGHSCORE_FILENAME, 'w') do |f|
      f.truncate(0)

      f.write(@highscore)
    end
  end

  def create_logic
    @logic = Logic.new(@input, Gosu, PieceFactory.new, LineCleaner.new, Scoring.new)
  end

  def end_game
    save_highscore

    close 
  end

  def update
    if @on_menu and @input.start then
      @on_menu = false

      create_logic
    end

    if not @on_menu then
      @logic.update 

      @highscore = @logic.score if @logic.score > @highscore

      @on_menu = true if @input.start and not @logic.running
    end

    end_game if @input.exit
  end

  def draw
    if @on_menu then
      @menu_font.draw_rel("BLOCKS", width / 2, height / 2, 0, 0.5, 0.5) 

      @highscore_font.draw_rel("Highscore: #{@highscore}", width / 2, height - 20, 0, 0.5, 0.5)
    end

    @drawing.draw(@logic) unless @on_menu
  end
end

window = GameWindow.new
window.show
