class Calculator

	def calculate(operation,first,second)

		if operation == "add"
			add(first,second)
		elsif operation == "div"
			div(first,second)
		elsif operation == "subs" 
			subs(first,second)
		elsif operation == "mul"
			mul(first,second)
		else
			@result = "Something does not work"
		end
				

	end


	def add(first,second)
		@result  = first + second
		@result

	end

	def div(first,second)
		
		@result  = first / second
		@result

	end


	def subs(first,second)
		
		@result  = first - second
		@result

	end


	def mul(first,second)
		
		@result  = first * second
		@result

	end



end

