require_relative '../config/environment'

controller_instance = Controller.new()

logged_in_therapist = controller_instance.welcome_screen

until !logged_in_therapist.nil?
  sleep 2
  logged_in_therapist = controller_instance.welcome_screen
end

controller_instance.therapist = logged_in_therapist

controller_instance.dashboard


Pry.start
