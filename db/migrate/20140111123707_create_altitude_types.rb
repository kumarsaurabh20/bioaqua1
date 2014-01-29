class CreateAltitudeTypes < ActiveRecord::Migration
  def self.up
    create_table :altitude_types do |t|
      t.string :name, :null => false
      t.timestamps
    end

  end

  def self.down
     drop_table :altitude_types
  end
end
