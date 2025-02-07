class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :country_code, null: false
      t.string :city_code, null: false
      t.string :name, null: false

      t.string :chain_code, null: false
      t.string :amadeus_id, null: false
      t.integer :dupe_id, null: false

      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
