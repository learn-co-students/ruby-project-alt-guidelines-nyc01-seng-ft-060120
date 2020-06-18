require_relative '../config/environment'

puts "Welcome to the Corona Tracking Application 🦠"
puts "What is your name?"
name_individual = gets.chomp

puts "
#{name_individual}, do you have any of the following symptoms(True or False)
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



Individual.create(
    name: name_individual,
    status: individual_status
    
)

puts "Hi,#{name_individual} What is your location?"
name_place = gets.chomp






puts "Your information has been saved!"