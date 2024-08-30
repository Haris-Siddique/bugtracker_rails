class Bug < ApplicationRecord 

  belongs_to :project

  belongs_to :developer, class_name: 'User'
  belongs_to :qa, class_name: 'User', optional: true
  belongs_to :manager, class_name: 'User', optional: true


  validates :title, presence: true
  validates :description, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  mount_uploader :screen_shot, ScreenShotUploader
  
end