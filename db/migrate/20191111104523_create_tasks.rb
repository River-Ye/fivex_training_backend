class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.datetime :start_time
      t.datetime :end_time
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
