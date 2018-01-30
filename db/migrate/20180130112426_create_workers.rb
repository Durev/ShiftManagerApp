class CreateWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :workers do |t|
      t.string :status
      t.string :first_name

      t.timestamps
    end
  end
end
