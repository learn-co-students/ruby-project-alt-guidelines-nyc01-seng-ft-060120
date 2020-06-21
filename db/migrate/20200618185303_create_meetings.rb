class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do|t|
      t.integer :time
      t.integer :date
      t.integer :individual_id
      t.integer :location_id
    end
  end
end
