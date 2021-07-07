require 'pry'
class CommandLineInterface

    def greet
        puts "Welcome to the Flatiron food ordering app."
        puts "Register by providing a username:"
    end

    def register
        input = gets.strip.capitalize
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

    def read_menu
        rest_input = gets.strip
        puts "___________________________"
        puts "Below are the menu items:"
        puts ""
        selected_rest = Restaurant.find_by(id: rest_input)
        puts selected_rest.return_menu_string
    end

    def food_selection_checker
        puts ""
        puts "***"
        puts "Please select your item by typing the food name:"
        puts ""
        food_input = gets.strip.titleize

        if !!MenuItem.find_by(food_name: food_input)
            MenuItem.find_by(food_name: food_input)
        else
            puts "You seem to have a typo. Try again"
            food_selection_checker
        end
    end

    def place_new_order(customer)
        food_selection = food_selection_checker
        customer.place_order(food_selection)
        puts ""
        puts "You have selected #{food_selection.food_name}, your order has been created!"
    end

    def additional_order(customer)
        self.restaurant_list
        self.read_menu
        self.place_new_order(customer)
        sleep 3
        self.next_choice(customer)
    end

    def next_step
        puts ""
        puts "What would you like to do next?"
            puts ""
        puts "1. Create New Order"
        puts "2. View Last Order"
        puts "3. Update Last Order"
        puts "4. Cancel Last Order"
        puts "5. Update Username"
        puts "6. Exit App"
        puts ""
        puts "___________________________"
        puts "Please enter your choice by typing a number below:"
        puts ""
    end

    def next_choice(customer)
        self.next_step
        next_step_input = gets.strip.to_i
        puts "___________________________"
        if next_step_input == 1
            self.additional_order(customer)
        elsif next_step_input == 2
            self.view_last_order(customer)
        elsif next_step_input == 3
            self.update_last_order(customer)
        elsif next_step_input == 4
            self.cancel_order(customer)
        elsif next_step_input == 5
            self.change_username(customer)
        elsif next_step_input == 6
            self.exit_app
        else
            puts "Invalid choice"
            sleep 2
            self.next_choice(customer)
        end
    end

    def update_last_order(customer)
        menu_obj = customer.last_order.menu_item
        puts "You will be updating the following order: "
        puts "#{menu_obj.food_name} ---> #{menu_obj.price}"
        sleep 3
        self.restaurant_list
        self.read_menu
        food_selection = food_selection_checker
        customer.update_last_order(food_selection)
        puts "Update Succesful!"
        self.view_last_order(customer)
    end

    def view_last_order(customer)
        puts "Your latest order is below"
        puts ""
        menu_obj = customer.last_order.menu_item
        puts "#{menu_obj.food_name} ---> #{menu_obj.price}"
        sleep 3
        self.next_choice(customer)
    end

    def change_username(customer)
        puts "What would you like to change your Username to?"
        puts ""
        new_un = gets.strip
        customer.change_username(new_un.titleize)
        puts ""
        puts "You've changed your Username to #{customer.username}!"
        puts "___________________________"
        sleep 3
        self.next_choice(customer)
    end

    def cancel_order(customer)
        customer.cancel_last_order
        puts ""
        puts "You successfully cancelled your last order."
        sleep 3
        self.next_choice(customer)
    end

    def exit_app
        puts "Goodbye!"
        sleep 3
        system "clear"
    end

    def run
        self.greet
        customer = self.register
        self.restaurant_list
        self.read_menu
        self.place_new_order(customer)
        self.next_choice(customer)
    end
end