class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :developers, :class_name => "User", foreign_key: "project_manager_id"
  
  belongs_to :project_manager
  
  has_and_belongs_to_many :projects

  validates_uniqueness_of :email




  def name
	  ename = ( self.first_name.nil? ? "" : self.first_name) + " "+ ( self.last_name.nil? ? "" : self.last_name)
	  return ename
  end	

end
