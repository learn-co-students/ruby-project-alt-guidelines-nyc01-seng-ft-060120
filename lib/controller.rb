class Controller
    attr_accessor :individual, :location, :prompt

    def initialize()
      @prompt = TTY::Prompt.new
    end

    def greetings
        system "clear"
        puts "Welcome to the Covid Tracing Application 🦠"
    
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Register", -> { Individual.register_a_user }
            menu.choice "Login", -> { Individual.login_a_user }
        end
    end
    
    def main_menu
        system "clear"
        puts "Welcome, #{self.individual.username}!"
        prompt.select("What would you like to do?") do |menu|
          menu.choice "Add Location", -> { self.add_location }
          menu.choice "Status?", -> {self.individual_status}
          menu.choice "See all my locations", -> { self.see_all_locations }
          menu.choice "Exit", -> { self.goodbye }
        end
    
    end
    
    
    def add_location
        puts "What is your location?"
        location = gets.chomp
        Location.create(name: location)
        self.main_menu
    end

    def individual_status
        Individual.all.each do |individual|
            puts individual.status
        end
        sleep 5
        self.main_menu
    end

    def see_all_locations
        Location.all.each do |location|
            puts "- #{location.name}"
        end
        sleep 5
        self.main_menu
    end

    def goodbye
        puts "Goodbye"
    end
    


end