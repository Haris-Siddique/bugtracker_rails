class Project < ApplicationRecord

 belongs_to :manager, class_name: 'User'

 has_many :projects_assigneds, dependent: :destroy
 has_many :assigned_users, through: :projects_assigneds, source: :user

 has_many :bugs, dependent: :destroy

 validates :project_name, presence: true


 

end