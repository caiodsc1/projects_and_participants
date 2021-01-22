class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :finish_date
      t.decimal :amount
      t.integer :risk

      t.timestamps
    end
  end
end
