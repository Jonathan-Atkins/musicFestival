class CreateScheduleShows < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_shows do |t|
      t.string :title
      t.date :date
      t.references :schedule, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
