class StringCalculator


	def calculate(string)
		
		@result  = string.split(",").reduce(0){|sum,number| sum + number.to_i}
		@result
	end


end

