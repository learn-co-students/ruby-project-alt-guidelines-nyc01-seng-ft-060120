class Controller

  attr_accessor :therapist, :prompt

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
    greetings
    self.therapist.reload
    selection = prompt.select("Hello, #{self.therapist.name}.\nSelect an Appointment to View/Edit, or Create an Appointment.",
    self.therapist.list_view)
    unless selection
      create_appointment ##
    else
      view_appoointment(selection)
    end
  end
    
  def view_appoointment(id)
    greetings
    appointment = Appointment.find(id)
    appointment_display = appointment.display
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
    scheduled_time = prompt.ask("When would like to schedule this appointment for?", convert: :datetime)
    status = "Scheduled"
    therapist = self.therapist
    appointment = Appointment.create(
      patient: patient,
      scheduled_time: scheduled_time,
      status: status,
      therapist:therapist
    )
    view_appoointment(appointment.id)
  end
  
  


  





end