class Controller

  attr_accessor :therapist, :prompt, :appointment

  def initialize
    @prompt = TTY::Prompt.new
  end
  
  def greetings
    system("clear")
    puts "Welcome to Therapow!"
  end
  
  def welcome_screen
    greetings
    prompt.select("What would you like to do?") do |menu|
      menu.choice "Register", -> { Therapist.register_a_therapist }
      menu.choice "Login", -> { Therapist.login_a_therapist }
    end
  end
  
  def dashboard
    self.appointment = nil
    greetings
    self.therapist.reload
    selection = prompt.select("Hello, #{self.therapist.name}.\nSelect an Appointment to View/Edit, or Create an Appointment.",
    self.therapist.list_view)
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
    
  def view_appointment
    greetings
    appointment_display = self.appointment.display
    prompt.select(appointment_display) do |menu|
      menu.choice "Edit this Appointment", ->{ self.edit_appointment } ##
      menu.choice "Delete this Appointment", -> { self.delete_appointment } ##
      menu.choice "Back to Dashboard", -> { self.dashboard }
    end
  end

  def create_appointment
    greetings
    patient_name = prompt.ask("Please enter your patient's name")  ## stretch goal: select a patient
    patient = Patient.find_by(name: patient_name)
    until patient
      puts "I couldn't find that patient.\n"
      patient_name = prompt.ask("Please enter your patient's name")
      patient = Patient.find_by(name: patient_name)
    end
    scheduled_time = Time.now + rand(10.days)
    prompt.ask("When would like to schedule this appointment for?")
    status = "Scheduled"
    therapist = self.therapist
    appointment = Appointment.create(
      patient: patient,
      scheduled_time: scheduled_time,
      status: status,
      therapist:therapist
    )
    self.appointment = appointment
    view_appointment
  end
  
  def edit_appointment
    hash = prompt.collect do
      key(:scheduled_time).ask("Change Scheduled Time")
      key(:patient).ask("Enter New Patient Name")
      key(:status).ask("Enter New Status")
      key(:note).ask("Enter a New Note")
    end
    
    appointment.scheduled_time = Time.now + rand(10.days) if hash[:scheduled_time]
    appointment.patient = Patient.find_by(name: hash[:patient]) if Patient.find_by(name: hash[:patient])
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