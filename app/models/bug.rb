class Bug < ApplicationRecord 

  belongs_to :project

  belongs_to :developer, class_name: 'User'
  belongs_to :qa, class_name: 'User'

  validates :title, presence: true
  validates :description, presence: true
  validates :type, presence: true
  validates :status, presence: true

  mount_uploader :screen_shot, ScreenShotUploader
  # validates :screen_shot, file_content_type: { allow: ['image/png', 'image/gif'] }

  
end