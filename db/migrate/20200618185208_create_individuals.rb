class CreateIndividuals < ActiveRecord::Migration[5.2]
  def change
    create_table :individuals do|t|
      t.string :name
      t.boolean :status
    end
  end
end
