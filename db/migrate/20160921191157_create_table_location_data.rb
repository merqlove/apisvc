class CreateTableLocationData < ActiveRecord::Migration[5.0]
  def up
    create_table :location_data do |t|
      t.decimal :latitude, precision: 30, scale: 4, null: false
      t.decimal :longitude, precision: 30, scale: 10, null: false
      t.string :name, null: false, default: ''
      t.string :timezone, default: 'Etc/UTC'
    end

    add_index :location_data, :name, unique: true
  end

  def down
    drop_table :location_data
  end
end
