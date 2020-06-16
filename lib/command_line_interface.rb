class CommandLineInterface

    def greet
        puts "Welcome to the Flatiron food ordering app."
        puts "Register by providing a username:"
    end

    def register(input)
        Customer.create(username: input)
        puts "Thank you for registering, #{}"
    end

    # def cancel_confirmation
    #     puts "Your last order is #{last_order}. Cancelling now."

    # end
end