class Board
	attr_reader :cells
	def initialize
		@cells = {}
	end

	def get_board(board_creator)
		@cells = board_creator
	end
end


class BoardCreator
	attr_reader :cells
	def initialize
		@cells = {}
	end
	def set_board_from_txt(txt)
		txt_board = IO.read(txt)
		create_columns(create_lines(txt_board))
		@cells
	end

	def create_lines(txt_board)
		lines = {}
		line_number = 8
		txt_board.split(/\n/).each do |line|
			lines[line_number] = line
			line_number -= 1
		end
		lines
	end

	def create_columns(lines)
		column_number = "a".ord
		lines.each do |key, line|
			split_line(key, line, column_number)
			column_number = "a".ord	
		end
	end

	def split_line(key, line, column_number)
		line.split(" ").each do |cell|
			create_key(column_number, key, cell)
			column_number += 1
		end	
	end

	def create_key(column_number, initial_key, cell)
		key = column_number.chr + initial_key.to_s	
		@cells[key.to_sym] = PieceCreator.new.create_piece(cell)
	end
end