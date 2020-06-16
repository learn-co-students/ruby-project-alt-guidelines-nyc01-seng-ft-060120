class Appointment < ActiveRecord::Base
  belongs_to :therapist
  belongs_to :patient

  def display
    text = "APPOINTMENT INFO\n"
    text += "_" * text.length
    text += "Scheduled for #{self.scheduled_time}\n\n"
    text += "With: #{self.patient.name}\n\n"
    text += "Status: #{self.status}\n\n"
    text += "NOTES:\n#{self.note}\n\n"
    text += "_" * 50
  end
  
  

end