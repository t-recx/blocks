class Piece
	attr_reader :x, :y, :current_block

	def initialize(x,y,blocks)
		@x, @y, @blocks = x, y, blocks

		@block_iterator = 0
		@current_block = blocks[@block_iterator]
	end

	def rotate(field, field_width, field_height)
		next_block_iterator = rotated_block_iterator
		next_block = @blocks[next_block_iterator]

		return if at_the_left_edge next_block, -1
		return if at_the_right_edge field_width, next_block, 1
		return if at_the_bottom_edge field_height, next_block
		return if path_is_occupied field, @x, @y, next_block

		@block_iterator = next_block_iterator 
		@current_block = next_block
	end

	def rotated_block_iterator
		if @block_iterator == @blocks.length - 1
			return 0
		end

		@block_iterator + 1
	end

	def path_is_occupied(field, nx, ny, block = @current_block)
		block.any?{|i| (field.any?{|f| f[0] == nx + i[0] && f[1] == ny + i[1]})}
	end

	def at_the_left_edge(block = @current_block, offset = 0)
		@x + (block.map{|i| i[0]}).min <= 0 + offset
	end

	def at_the_right_edge(field_width, block = @current_block, offset = 0)
		@x + (block.map{|i| i[0]}).max >= field_width - 1 + offset
	end

	def at_the_bottom_edge(field_height, block = @current_block)
		@y + (block.map{|i| i[1]}).max >= field_height - 1 
	end

	def move_left(field)
		@x -= 1 unless at_the_left_edge or path_is_occupied(field, @x-1, @y)
	end

	def move_right(field, field_width)
		@x += 1 unless at_the_right_edge(field_width) or path_is_occupied(field, @x+1, @y)
	end

	def move_down(field, field_height)
		prev_y = @y

		@y += 1 unless at_the_bottom_edge(field_height) or path_is_occupied(field, @x, @y+1)
	
		return prev_y != @y
	end

	def drop(field, field_height)
		prevY = -1

		until prevY == @y do
			prevY = @y
			move_down(field, field_height)
		end
	end
end
