require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
input = gets.strip.capitalize
cli.register(input)
customer = Customer.all.last
cli.restaurant_list
rest_input = gets.strip
puts cli.read_menu(rest_input)
puts ""
puts "***"
puts "Please select your item by typing the food name:"
puts ""
food_input = gets.strip.titleize
cli.place_new_order(customer,food_input)