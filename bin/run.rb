require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
input = gets.strip.capitalize
cli.register(input)
customer = Customer.all.last
cli.restaurant_list
rest_input = gets.strip
puts cli.read_menu(rest_input)
cli.test_space_select_item
food_input = gets.strip.titleize
cli.place_new_order(customer,food_input)
cli.next_choice(customer)