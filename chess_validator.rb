require 'pry'
class ChessValidator
	def initialize
		
	end

	def check(board, movelist)
		movelist.each do |move|
			if is_legal(board, move)
				puts "LEGAL"
			else
				puts "ILEGAL"
			end
		end
	end

	def is_legal(board, move)
		piece = get_piece(board, move)
		destiny = get_destiny(move)
		piece.check_moves(destiny)
	end

	def get_piece(board, move)
		board.cells[move[0]]
	end

	def get_destiny(move)
		move[1]
	end
end

class Board
#create board from IO file	
	attr_reader :cells
	def initialize
		@cells = {
			a1: Bishop.new,
			a2: Rook.new,
			a3: "knight"
		}
	end

end

# class Cell
# #store a piece
# 	def initialize
# 		@piece
# 		@position
# 	end
# end

class Piece
#store the possible moves of a piece
	attr_reader :moves
	def initialize
		@moves = :a3
		@color
	end
end

class Rook < Piece
	def check_moves(destiny)
		# binding.pry
		@moves == destiny

	end
end

class Bishop < Piece

end


class MovesList
#create a list of moves from IO file
	def initialize
		@moves
	end
end



movelist = [[:a2, :a3], [:a2, :a4]]
board = Board.new


validator = ChessValidator.new
validator.check(board, movelist)
