class AddIndexesToTasks < ActiveRecord::Migration[8.1]
  def change
    add_index :tasks, :created_at
    add_index :tasks, :status
    add_index :tasks, :priority
    add_index :tasks, :due_date
  end
end
