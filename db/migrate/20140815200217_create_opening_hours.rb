class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.references :place
      t.foreign_key :places, dependent: :delete
      t.integer :week_day
      t.time :open, null: false
      t.time :close, null: false

      t.index [:place_id, :week_day], unique: true
    end
  end
end
