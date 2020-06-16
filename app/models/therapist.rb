class Therapist < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments

  def list_view
    array = self.appointments.map do |a|
      text = "_" * 30 
      text += "\n"
      text += "#{a.scheduled_time} Status: #{a.status}\n"
      text += "With #{a.patient.name}"

      { "#{text}" => a.id } 
    end
    array << { "Create an Appointment" => "Create" }
    array << { "Quit" => "Quit" }
  end
  
  ##  CLASS METHODS  ##
  
  def self.register_a_therapist
    puts "let's sign you up!"
    puts "What is your name?"
    name = gets.chomp
    puts "Aight, what's your password?"
    pass = gets.chomp
    if Therapist.find_by(name: name)
      puts "Sorry, a therapist with that Name exists"
    else
      Therapist.create(name: name)
    end
  end

  def self.login_a_therapist
    puts "What is your name?" 
    name = gets.chomp
    # pass = TTY::Prompt.new.mask("What is your password?")
    if Therapist.find_by(name: name)
      Therapist.find_by(name: name)
    else
      puts "Sorry, you don't exist."
    end 
  end


  
end