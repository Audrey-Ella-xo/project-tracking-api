class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :created_by

      t.timestamps
    end
  end
end
