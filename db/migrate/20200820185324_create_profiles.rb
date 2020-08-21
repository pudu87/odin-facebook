class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      
      t.date :birthdate
      t.string :location
      t.string :sex
      t.belongs_to :user

      t.timestamps
    end
  end
end
