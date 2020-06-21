class Individual < ActiveRecord::Base
    has_many :meetings
    has_many :locations, through: :meetings

    def self.register_a_user
        puts "Okay, let's sign you up!"
        puts "What is your name?"
        name_individual = gets.chomp
        puts "#{name_individual} what is your username?"
        username = gets.chomp
        puts "Okay, what's is your password?"
        pass = gets.chomp
        puts "
            #{name_individual}, have you had any of the following symptoms in the last 30 days
            -Fever or chills
            -Cough
            -Shortness of breath or difficulty breathing
            -Fatigue
            -Muscle or body aches
            -Headache
            -New loss of taste or smell
            -Sore throat
            -Congestion or runny nose
            -Nausea or vomiting
            -Diarrhea
        " 
        individual_status = gets.chomp
        if Individual.find_by(username: username)
          puts "Sorry, a user with that Username exists."
        else
          Individual.create(
            username: username, 
            password: pass,
            name: name_individual,
            status: individual_status
        )
        end
    end
        
    
    def self.login_a_user
        puts "What is your username?"
        username = gets.chomp
    
        pass = TTY::Prompt.new.mask("What is your password?")
    
        if Individual.find_by(username: username, password: pass)
          Individual.find_by(username: username, password: pass)
        else
          puts "Sorry, a user cannot be found."
        end
    end
    
    

    



end