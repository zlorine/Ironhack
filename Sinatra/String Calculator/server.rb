require "sinatra"
require "sinatra/reloader"
require 'pry'
require "./lib/string.rb"

get "/string_calculator" do
erb(:string_calculator)
end 

post "/calculate_add" do

@first_number = params[:first_number]
@second_number = params[:second_number]
calc = StringCalculator.new
@solution = calc.calculate("#{@first_number},#{@second_number}")
erb(:string_calculator)
# binding.pry

end
