class AddZipCodeToFestivals < ActiveRecord::Migration[7.1]
  def change
    add_column :festivals, :zip_code, :string
  end
end
