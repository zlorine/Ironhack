require  = pry

board = []
for n in 1..8
line = ("a"..."i").map{ |letter| letter + n.to_s}
board << line
end

board.each do |line|
	line.each do |square|
		puts square.to_s
	end
end
