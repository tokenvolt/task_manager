class Task < ActiveRecord::Base
  attr_accessible :title
  
  has_many :user_tasks, :dependent => :destroy
  has_many :users, :through => :user_tasks
  has_many :sharing_users, :through => :user_tasks, :source => :user_who_shared

  validates :title, :presence => true

  def shared_with(current_user)
    sharing_users.joins(:user_tasks).where("user_tasks.user_id = ?", "#{current_user.id}").limit(1)
  end
end

