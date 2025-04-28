class CreateStages < ActiveRecord::Migration[7.1]
  def change
    create_table :stages do |t|
      t.string :name
      t.references :festival, null: false, foreign_key: true

      t.timestamps
    end
  end
end
