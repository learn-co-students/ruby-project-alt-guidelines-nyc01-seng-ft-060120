class Appointment < ActiveRecord::Base
  belongs_to :therapist
  belongs_to :patient

  # def display(controller)
  #   text = "APPOINTMENT INFO\n"
  #   text += "_" * text.length
  #   text += "\n"
  #   text += "Scheduled for #{self.scheduled_time}\n\n"
  #   text += "With: #{controller.counterpart_instance.name}\n\n"
  #   text += "Status: #{self.status}\n\n"
  #   text += "NOTES:\n#{self.note}\n\n"
  #   text += "_" * 50
  #   text += "\n"
  # end
  
  # def list_view
  #     text = "_" * 30 
  #     text += "\n"
  #     text += "#{scheduled_time} Status: #{status}\n"
  #     text += "With #{patient.name}"
  #     text
  # end
  

end