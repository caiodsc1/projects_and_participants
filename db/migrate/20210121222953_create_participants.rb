class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
