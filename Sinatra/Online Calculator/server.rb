require "sinatra"
require "sinatra/reloader"
require 'pry'
require "./lib/calc.rb"
enable :sessions

get "/string_calculator" do
@first_number = session[:first_number]
@second_number = session[:second_number]
@solution = session[:solution]
erb(:string_calculator)
end 

post "/calculate_add" do

session[:first_number] = params[:first_number].to_f
session[:second_number] = params[:second_number].to_f
operation = params[:operation]
first_number = session[:first_number]
second_number = session[:second_number]
calc = Calculator.new
session[:solution] = calc.calculate(operation,first_number,second_number)
redirect to "/string_calculator"


end

