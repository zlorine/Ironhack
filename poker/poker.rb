require 'pry'

class Poker
attr_accessor :count1, :count2
	def initialize
		@@count1 = 0
		@@count2 = 0
		@@count3 = 0
		File.open("./poker.txt") do |file|
 		file.each_line do |line|
   		ar = line.split(' ')
   		Round.new(ar[0..4], ar[5..9]);
  		end
		end
		puts "Player 1 wins #{@@count1} times!"
		puts "Player 2 wins #{@@count2} times!"
		puts "and there have been #{@@count3} draws!"
	end
end

class Round < Poker

	def initialize(pl1,pl2)
		@pl1 = Hand.new(pl1)
		@pl2 = Hand.new(pl2)
		p @pl1.result
		p @pl2.result
		puts "__________"
		compare(@pl1.result,@pl2.result)
	end

	def compare(pl1,pl2)
		if pl1[0] > pl2[0]	
		pl1_wins
		elsif pl1[0] == pl2[0]
			
			if pl1[1] > pl2[1]
			pl1_wins
			elsif pl1[1] == pl2[1]
				if pl1[2] > pl2[2]
					pl1_wins
				elsif pl1[2] < pl2[2]
					pl2_wins
				else
				draw
				end

			else
			pl2_wins
			end

		else
			pl2_wins
		end
	end

	def pl1_wins
		@@count1 = @@count1 + 1
	end

	def pl2_wins
		@@count2 = @@count2 + 1
	end

	def draw
		@@count3 = @@count3 + 1
	end

end


class Hand
attr_reader :result

RANKS = {
            9 => :royal_flush,
            8 => :straight_flush,
            7 => :poker,
            6 => :full_house,
            5 => :flush,
            4 => :straight,
            3 => :tris,
            2 => :two_pairs,
            1 => :pair,
            0 => :empty,
          }.freeze

VALUES = {
			2 => '2',
		    3 => '3',
		    4 => '4',
		    5 => '5',
		    6 => '6',
		    7 => '7',
		    8 => '8',
		    9 => '9',
		    10 => 'T',
		    11 => 'J',
		    12 => 'Q',
		    13 => 'K',
		    14 => 'A',

		 }.freeze

SUITS =  {
		    0 => "C",
		    1 => "D",
		    2 => "H",
		    3 => "S",
		 }.freeze

	def initialize(hand)
		@hand = hand
		@cards = []
		@hand.each do |card|
			@cards << card.split("")
		end
		@values = []
		@suits = []
		@result = []
		evaluate
	end

	def evaluate
		
		@cards.each do |value, suit| 
		card_value = VALUES.select {|number,v| value == v}
		card_suit = SUITS.select {|number,s| suit == s}
		card_value.each do |key, value|
			@values << key
		end
		card_suit.each do |key, value|
			@suits << key
		end
		@values.sort!
		@suits.sort!
		end

		if flush 
			if straight || low_straight
				if royal
					@result << RANKS.key(:royal_flush)
					@result << highest
				elsif						
					@result << RANKS.key(:straight_flush)
					@result << highest
				end
				elsif 
					@result << RANKS.key(:flush)
					@result << highest
			end

		elsif poker
					@result << RANKS.key(:poker)
					@result << @score[0].to_i
		elsif house
					@result << RANKS.key(:full_house)
					@result << @score[0].to_i
		elsif straight || low_straight
					@result << RANKS.key(:straight)
					@result << @score
		elsif tris
					@result << RANKS.key(:tris)
					@result << @score[0].to_i
		elsif pair
			if @score_pair.length == 2
					@result << RANKS.key(:two_pairs)
					@result << @score_pair.max
			else
					@result << RANKS.key(:pair)
					@result << @score_pair[0].to_i
			end
		else
					@result << RANKS.key(:empty)
					@result << highest	
		end
		@result << highest

	end

	def flush
		@suits.all? {|card| card == @suits[0]}
		# we use all? to check if every suit is equal to the first suit
	end

	def straight
		@score = highest
		@values.each_cons(2).all? {|x, y| y == x + 1}
		# each cons takes pairs of 2 consecutive numbers (not mathematically, but from the array), 
		# then we check for the second number to be always one more than the second
		# finally, we use all to make get a true / false result. 
	end

	def low_straight
		@score = @values[4]
		@values[1..4].each_cons(2).all? {|x, y| y == x + 1} && @values[0] == '14'		
	end

	def royal
		@values.reduce {|sum, x| sum + x} == 60
	end

	def pair
		duplicates = @values.select {|value| @values.count(value) == 2}
		@score_pair = duplicates.uniq!
		# we select those elements which 'count' 2 times.
	end

	def tris
		tris = @values.select {|value| @values.count(value) == 3}
		@score = tris.uniq!
	end

	def poker
		poker = @values.select {|value| @values.count(value) == 4}
		@score = poker.uniq!
	end

	def house
		tris && pair
	end

	def highest
		@values.max
	end

end

Poker.new

