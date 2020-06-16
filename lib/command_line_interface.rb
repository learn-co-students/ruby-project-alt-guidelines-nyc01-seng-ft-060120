require 'pry'
class CommandLineInterface

    def greet
        puts "Welcome to the Flatiron food ordering app."
        puts "Register by providing a username:"
    end

    def register(input)
        person = Customer.create(username: input)
        puts "Thank you for registering, #{input}"
        return person
    end

    def restaurant_list
        puts "Here is a list of all restaurants."
        allrestaurant = Restaurant.all.each_with_index do |rest, index|
            puts "#{index + 1}. " + rest.name
        end
        puts "___________________________"
        puts "To view a restaurant's menu, select the restaurant's cooresponding number:"
        puts ""
    end

    def read_menu(rest_input)
        puts "___________________________"
        puts "Below are the menu items:"
        puts ""
        selected_rest = Restaurant.find_by(id: rest_input)
        selected_rest.return_menu_string
       
     
    end

    def place_new_order(customer,food)
        
        food_selection = MenuItem.find_by(food_name: food)
        customer.place_order(food_selection)
        puts ""
        puts "You have selected #{food_selection.food_name}, your order has been created!"
    end


    # def cancel_confirmation
    #     puts "Your last order is #{last_order}. Cancelling now."

    # end
end