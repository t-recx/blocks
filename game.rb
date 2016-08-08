require 'gosu'
require './logic.rb'
require './piece_factory.rb'
require './input.rb'
require './line_cleaner.rb'
require './scoring.rb'
require './drawing.rb'

class GameWindow < Gosu::Window
	def initialize
		super 280, 320
		self.caption = "Blocks"

		@input = Input.new(200)
		@drawing = Drawing.new(width, height)
		@logic = Logic.new(@input, Gosu, PieceFactory.new, LineCleaner.new, Scoring.new)
	end

	def update
		@logic.update

		close if @input.exit
	end

	def draw
		@drawing.draw(@logic)
	end
end

window = GameWindow.new
window.show
