class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :user_type, presence: true

  has_many :projects, foreign_key: 'manager_id', dependent: :destroy

  has_many :projects_assigneds, dependent: :destroy
  has_many :assigned_projects, through: :projects_assigneds, source: :project

  has_many :bugs_as_developer, class_name: 'Bug', foreign_key: 'developer_id'
  has_many :bugs_as_qa, class_name: 'Bug', foreign_key: 'qa_id', dependent: :destroy
  has_many :bugs_as_manager, class_name: 'Bug', foreign_key: 'manager_id', dependent: :destroy

 


  def manager?
    user_type == 'manager'
  end

  def developer?
    user_type == 'developer'
  end

  def qa?
    user_type == 'qa'
  end
end
