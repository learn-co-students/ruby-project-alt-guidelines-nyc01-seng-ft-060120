class Appointment < ActiveRecord::Base
    belongs_to :therapist
    belongs_to :patient
end