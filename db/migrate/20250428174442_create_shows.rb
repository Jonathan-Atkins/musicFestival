class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.string :artist
      t.string :location
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
