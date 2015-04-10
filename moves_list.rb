class MovesList
#create a list of moves from IO file
	def initialize
		@moves = []
	end

	def create_list_from_txt(txt)
		moves = IO.read(txt)
		@moves = moves.split(/\n/).map{|move| move.split(" ")}
		convert_moves_in_symbol
	end

	def convert_moves_in_symbol
		@moves.map! do |move|
			move.map do |position|
				position.to_sym
			end
		end
	end
end


movelist = [[:e5, :b2], [:e5, :g7], [:e5, :b8], [:e5, :h2], [:e5, :e1], [:e5, :f1], [:e5, :e6], [:e5, :f6], [:e5, :d5]]
