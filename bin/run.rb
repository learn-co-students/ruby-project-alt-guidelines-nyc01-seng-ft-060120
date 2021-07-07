require_relative '../config/environment'
ActiveRecord::Base.logger = nil
puts "hello world"

class CommandLineInterface

  def slow_puts(text)
      text.each_char do |c| 
        print c
        sleep 0.01 
      end 
      puts
  end
  
  def greet
    slow_puts "Welcome to Felp, the best resource for restaurant information in the world!"
  end  

  def run
    greet
    slow_puts "Thinking of eating somewhere but not sure if it's good? We can help you with that decision!"
    slow_puts "Enter a restaurant name to get started:"
    restautant_name = gets.chomp
    restaurant = Restaurant.find_by(name: restautant_name)
    Restaurant.all.sample.show_reviews

  end

end




system("clear")
sleep 0.5
cli = CommandLineInterface.new
cli.run