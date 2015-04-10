class ChessValidator
	def initialize
		
	end

	def checkmoves(movelist, board)
		movelist.each do |move|
			get_cell
			get_content
			get_possible_moves
			print_legality
		end
	end

end

class Board
#create board from IO file	
	def initialize
		@cells
	end

end

class Cell
#store a piece
	def initialize
		@piece
		@position
	end
end

class Piece
#store the possible moves of a piece
	def initialize
		@moves
		@color
	end
end

class MovesList
#create a list of moves from IO file
	def initialize
		@moves
	end
end