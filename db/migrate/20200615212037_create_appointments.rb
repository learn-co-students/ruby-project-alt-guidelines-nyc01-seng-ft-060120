class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.integer :therapist_id
      t.string :status
      t.datetime :scheduled_time
      t.string :note      
    
      t.timestamps
    end
    
  end
end
