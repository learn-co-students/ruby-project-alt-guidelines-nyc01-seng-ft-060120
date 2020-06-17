class Controller

  attr_accessor :user, :prompt, :appointment, :counterpart_class, :counterpart_instance

  def initialize
    @prompt = TTY::Prompt.new
  end

  def user_class
    self.user.class
  end
  
  def counterpart_class
    if self.user_class == Patient
      Therapist
    elsif self.user_class == Therapist
      Patient
    end
  end

  def class_to_string(cls)
    cls.to_s
  end

  def class_to_sym(cls)
    class_to_string(cls).to_sym.downcase
  end
  
  def greetings
    system("clear")
    puts "Welcome to Therapow!"
  end

  def welcome_screen
    greetings
    prompt.select("Are you a patient or a therapist?") do |menu|
      menu.choice "Patient", -> {Patient}
      menu.choice "Therapist", -> {Therapist}
    end
  end

  def login_page
    greetings
    prompt.select("What would you like to do?") do |menu|
      menu.choice "Register", -> { self.register}
      menu.choice "Login", -> { self.login}
    end
  end
  
  def login
    puts "What is your name?" 
    name = gets.chomp
    # pass = TTY::Prompt.new.mask("What is your password?")
    if self.user.find_by(name: name)
      self.user.find_by(name: name)
    else
      puts "Sorry, you don't exist."
    end 
  end

  def register
    puts "let's sign you up!"
    puts "What is your name?"
    name = gets.chomp
    puts "Aight, what's your password?"
    pass = gets.chomp
    if self.user.find_by(name: name)
      puts "Sorry, a #{class_to_string(self.user)} with that name exists"
    else
      user.create(name: name)
    end
  end
  
  def appointment_list_view(appointment)
    if user.class == Patient
      appointment_counterpart = appointment.therapist
    elsif user.class == Therapist
      appointment_counterpart = appointment.patient
    end
      text = "_" * 30 
      text += "\n"
      text += "#{appointment.scheduled_time} Status: #{appointment.status}\n"
      text += "With #{appointment_counterpart.name}"
      text
  end

  def dashboard
    self.appointment = nil
    self.counterpart_instance = nil
    greetings
    self.user.reload
    selection = prompt.select("Hello, #{self.user.name}.\nSelect an Appointment to View/Edit, or Create an Appointment.",
    self.user.appointments.map do |a| 
      {self.appointment_list_view(a) => a.id }
    end.chain(
      [
        { "Create an Appointment" => "Create" },
        { "Quit" => "Quit" }
      ]
    ).to_a 
      )
    case selection
    when "Create"
      create_appointment
    when "Quit"
      quit
    else
      self.appointment = Appointment.find(selection)
      self.view_appointment
    end
  end

  def display_appointment
    if user.class == Patient
      appointment_counterpart = appointment.therapist
    elsif user.class == Therapist
      appointment_counterpart = appointment.patient
    end
    text = "APPOINTMENT INFO\n"
    text += "_" * text.length
    text += "\n"
    text += "Scheduled for #{self.appointment.scheduled_time}\n\n"
    text += "With: #{appointment_counterpart.name}\n\n"
    text += "Status: #{self.appointment.status}\n\n"
    text += "NOTES:\n#{self.appointment.note}\n\n"
    text += "_" * 50
    text += "\n"
  end

  def view_appointment
    greetings
    prompt.select(self.display_appointment) do |menu|
      menu.choice "Edit this Appointment", ->{ self.edit_appointment } ##
      menu.choice "Delete this Appointment", -> { self.delete_appointment } ##
      menu.choice "Back to Dashboard", -> { self.dashboard }
    end
  end

  def create_appointment
    greetings
    counterpart_name = prompt.ask("Please enter your #{self.class_to_string(counterpart_class)}'s name")  ## stretch goal: select a patient
    self.counterpart_instance = counterpart_class.find_by(name: counterpart_name)
    until counterpart_instance
      puts "I couldn't find that #{self.class_to_string(counterpart_class)}.\n"
      counterpart_name = prompt.ask("Please enter your #{self.class_to_string(counterpart_class)}'s name")
      countepart_instance = counterpart.find_by(name: counterpart_name)
    end
    prompt.ask("When would you like to schedule this appointment for?")
    self.appointment = Appointment.create(
      class_to_sym(counterpart_class) => counterpart_instance,
      class_to_sym(self.user_class) => self.user,
      scheduled_time: Time.now + rand(10.days),
      status: "Scheduled"
    )
    # counterpart_symbol = counterpart.to_s.to_sym.downcase
    # user_symbol = self.user.class.to_s.to_sym.downcase
    # appointment = Appointment.new 
    # appointment.send(("#{user_symbol}="),self.user)
    # appointment.send(("#{counterpart_symbol}="),counterpart_instance)
    # appointment.scheduled_time = scheduled_time
    # appointment.status = status
    # appointment.save
    # self.appointment = appointment
    view_appointment
  end
  
  def edit_appointment
    if user.class == Patient
      appointment_counterpart = appointment.therapist
    elsif user.class == Therapist
      appointment_counterpart = appointment.patient
    end
    counterpart_class_sym = class_to_sym(appointment_counterpart.class)
    counterpart_class_string = class_to_string(appointment_counterpart.class)
    hash = prompt.collect do
      key(:scheduled_time).ask("Change Scheduled Time")
      key(counterpart_class_sym).ask("Enter New #{counterpart_class_string} Name")
      key(:status).ask("Enter New Status")
      key(:note).ask("Enter a New Note")
    end
    
    appointment.scheduled_time = Time.now + rand(10.days) if hash[:scheduled_time]
    appointment_counterpart = appointment_counterpart.class.find_by(name: hash[counterpart_class_sym]) if appointment_counterpart.class.find_by(name: hash[counterpart_class_sym])
    appointment.status = hash[:status] if hash[:status]
    appointment.note = hash[:note] if hash[:note]

    view_appointment
    
  end

  def delete_appointment
    sleep 1
    delete = prompt.yes?("Are you suuuuuure you want to delete this appointment?")
    if delete
      appointment.destroy
      puts "):  Appointment Deleted  :("
      dashboard
    else
      view_appointment
    end
    
  end
  
  def quit
    system("clear")
    sleep 0.5
    puts "Bye bye!"
    system("clear")
  end
  
  
  


  





end