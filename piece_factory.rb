require './piece.rb'
require './piece_types.rb'

class PieceFactory
  def get_new_piece(x, y, blocks)
		blocks = get_new_blockset unless blocks

		Piece.new(x, y, blocks)
	end

	def get_new_blockset
		PieceTypes::BLOCKS[Random.new.rand(PieceTypes::BLOCKS.length)]
	end
end
