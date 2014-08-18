class AllowNullOnMainPhone < ActiveRecord::Migration
  def change
    change_column_null(:places, :main_phone, true)
  end
end
