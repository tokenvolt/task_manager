class Task < ActiveRecord::Base
  attr_accessible :body, :title
  
  has_many :user_tasks, :dependent => :destroy
  has_many :users, :through => :user_tasks

  validates :title, :presence => true

end
