class CreateTask2s < ActiveRecord::Migration[8.1]
  def change
    create_table :task2s do |t|
      t.string :title
      t.string :string
      t.text :description

      t.timestamps
    end
  end
end
