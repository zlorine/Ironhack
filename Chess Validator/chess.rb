require "pry"


# class Game
# 	def initialize
# 		@game = Board.new
# 	end



# 	def checkSquare(square)
		
				

# 	end



# end


class Board
attr_accessor :board

	def initialize


		@positions = []

			for n in 0..7

				(0..7).each do |coord| 
					square = [n,coord]
					@positions << square

				end

			end

		@board = Hash[@positions.map {|pos| [pos, nil]}]

		addPieces

	end

		def addPieces
				wR1 = Rook.new("wR","white")
				bR1 = Rook.new("bR","black")
				wR2 = Rook.new("wR","white")
				bR2 = Rook.new("bR","black")
				@board[[0,0]] = bR1
                @board[[7,0]] = wR1
                @board[[0,7]] = bR2
                @board[[7,7]] = wR2             
                # binding.pry
		end		


		def checkSquare(a,b)

				if @board[[a,b]]
					puts "Position (#{a}, #{b}) = " +@board[[a,b]].name
				else
					puts "Position (#{a}, #{b}) = empty!"
				end

		end

		def getMove

			puts "From where?"
			answerFrom = gets.chomp.split(",")
			from = [answerFrom[0].to_i,answerFrom[1].to_i]


			puts "Where to?"
			answerTo = gets.chomp.split(",")
			to = [answerTo[0].to_i,answerTo[1].to_i]


			checkMove(from,to) 
			# binding.pry
			@board[from].checkPiece(from,to)
			move(from, to) 

		end


		def checkMove(from,to)
			    	
    		from.each do |x| 

				unless x.between?(0,7)
					puts "Attention! Wrong move. 'From' value does not exist."
					getMove
				end
				
			end

			to.each do |y|
										
				unless y.between?(0,7)
					puts "Attention! Wrong move. 'To' value does not exist."
					getMove
				end		
			end
	

		end			

		def capture
			puts "capture!"
		end   


		def move(from,to)

# binding.pry
				
				if  @board[from] == nil
					puts "Attention! There is no piece there."
				elsif @board[to].color == @board[from].color
					puts "Attention! you already have a piece there."
				elsif @board[to].color != @board[from].color
					capture
				else	
					@board[to] = @board[from]
					@board[from] = nil
				end
		
		end

end



class Piece
attr_reader :name, :piece, :color
	def initialize(name,color)
		@name=name	
		@color=color	
	end


end

class Rook < Piece

	def checkPiece(from,to)


puts "we'll check what a Rook can do"
		# binding.pry

	end
				

end


game = Board.new
game.checkSquare(0,0)
game.checkSquare(2,0)
game.getMove
game.checkSquare(0,0)
game.checkSquare(2,0)










			# @board.each do |line|
			# 		line.each do |square|
			# 		print square.to_s
			# 		end
			# 	puts ''
			# 	end


			# @codes = []
			# 	for n in 8.downto(1)
			# 		square =  ["a".."h"].each do |sq| sq + n.to_s
			# 		@codes << square
			# 	end


			# 	end

