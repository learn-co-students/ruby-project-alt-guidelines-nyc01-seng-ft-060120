require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
cli.register
customer = Customer.all.last
cli.restaurant_list
cli.read_menu
cli.place_new_order(customer)
cli.next_choice(customer)