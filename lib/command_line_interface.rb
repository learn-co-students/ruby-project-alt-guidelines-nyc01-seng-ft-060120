class CommandLineInterface

    def greet
        puts "Welcome to the Flatiron food ordering app."
        puts "Register by providing a username:"
    end

    def register(input)
        Customer.create(username: input)
        puts "Thank you for registering, #{input}"
    end

    def restaurant_list
        puts "Here is a list of all restaurants. Select a restaurant to view it's menu:"
        allrestaurant = Restaurant.all.each_with_index do |rest, index|
            puts "#{index + 1}. " + rest.name
        end
    end

    def read_menu
        puts 
    end

    def place_new_order
    end

    # def cancel_confirmation
    #     puts "Your last order is #{last_order}. Cancelling now."

    # end
end