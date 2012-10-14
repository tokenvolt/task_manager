class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :recoverable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  has_many :user_tasks, :dependent => :destroy
  has_many :tasks, :through => :user_tasks, :uniq => true

  def share(task, with_whom_shared)
  	sharing = UserTask.new
  	sharing.user_id = with_whom_shared.id
  	sharing.task_id = task.id
  	sharing.user_who_shared_id = self.id
  	sharing.save
  end
end