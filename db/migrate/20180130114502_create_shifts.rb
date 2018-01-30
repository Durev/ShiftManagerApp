class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.date :start_date
      t.references :worker, foreign_key: true

      t.timestamps
    end
  end
end
