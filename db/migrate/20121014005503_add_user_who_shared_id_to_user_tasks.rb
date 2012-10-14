class AddUserWhoSharedIdToUserTasks < ActiveRecord::Migration
  def change
    add_column :user_tasks, :user_who_shared_id, :integer
  end
end
