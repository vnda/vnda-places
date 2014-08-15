class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string  :name,           null: false
      t.string  :address_line_1, null: false, limit: 80
      t.string  :address_line_2, limit: 80
      t.string  :city,           null: false, limit: 80
      t.string  :district
      t.string  :postal_code,    null: false
      t.string  :main_phone,     null: false
      t.string  :home_page
      t.float   :lat
      t.float   :lon
      t.string  :images,         array: true
      t.string  :description,    limit: 200
      t.string  :email
      t.string  :alt_phone
      t.string  :mobile_phone
      t.string  :fax
      t.boolean :only_cash,      null: false, default: false
      t.string  :categories,     null: false, array: true

      t.references :state, null: false
      t.foreign_key :states

      t.timestamps
    end
  end
end
