class UserTask < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, :foreign_key => "user_id"
  belongs_to :task, :foreign_key => "task_id"
end
