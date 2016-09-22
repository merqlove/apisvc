class CreateTableTimeData < ActiveRecord::Migration[5.0]
  def up
    create_table :time_data do |t|
      t.datetime :value, null: false
    end

    add_index :time_data, :value, unique: true
  end

  def down
    drop_table :time_data
  end
end
