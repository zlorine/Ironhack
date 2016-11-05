require "sinatra"
require "sinatra/reloader"
require 'pry'
require "./lib/calc.rb"
enable :sessions

get "/calculator" do

@first_number = session[:first_number]
@second_number = session[:second_number]
@solution = session[:solution]
@picked = session[:picked]
@results = session[:results]
erb(:calculator)

end 

post "/calculate_add" do

session[:first_number] = params[:first_number].to_f
session[:second_number] = params[:second_number].to_f
operation = params[:operation]
first_number = session[:first_number]
second_number = session[:second_number]
calc = Calculator.new
session[:solution] = calc.calculate(operation,first_number,second_number)
redirect to "/calculator"

end

post "/delete_result" do
	if params[:delete] == "yes"
		session[:solution] = nil
		@results = session[:results]
		erb(:calculator)
		redirect to "/calculator"
	end
end


post "/save_result" do

	session[:results].to_a << session[:solution]
	session[:solution]
	@results = session[:results]
	binding.pry
	erb(:calculator)
	redirect to "/calculator"

end

post "/reuse" do

	session[:picked] = params[:results]
	@results = session[:results]
	erb(:calculator)
	redirect to "/calculator"


end
