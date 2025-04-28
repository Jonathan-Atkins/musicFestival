class AddStageToShows < ActiveRecord::Migration[7.1]
  def change
    add_reference :shows, :stage, null: false, foreign_key: true
  end
end
