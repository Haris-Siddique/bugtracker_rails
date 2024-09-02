class Bug < ApplicationRecord 

  belongs_to :project

  belongs_to :developer, class_name: 'User'
  belongs_to :qa, class_name: 'User', optional: true
  belongs_to :manager, class_name: 'User', optional: true


  validates :title, presence: true
  validates :title, uniqueness: { scope: :project_id, message: 'must be unique within a project', case_sensitive: false }
  validates :description, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  mount_uploader :screen_shot, ScreenShotUploader

  enum bug_type: {bug: 0, feature: 1}
  enum status: {pending: 0, started: 1, completed: 2, resolved: 3}
  
end