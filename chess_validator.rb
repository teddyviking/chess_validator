class ChessValidator
	def initialize
		
	end

	def check(board, movelist, destination)
		output = ""
		movelist.each do |move|
			if is_legal(board, move)
				output << "#{move}: LEGAL\n"
			else
				output << "#{move}: ILEGAL\n"
			end
		end
		puts output
		IO.write(destination, output)
	end

	def is_legal(board, move)
		piece = get_piece(board, move)
		origin = get_origin(move)
		destiny = get_destiny(move)
		piece.check_moves(origin, destiny) unless piece.class == String
		
	end

	def get_piece(board, move)
		board.cells[move[0]]
	end

	def get_origin(move)
		move[0]
	end

	def get_destiny(move)
		move[1]
	end
end