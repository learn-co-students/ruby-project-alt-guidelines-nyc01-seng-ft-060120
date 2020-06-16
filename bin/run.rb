require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
input = gets.strip
cli.register(input)
cli.restaurant_list