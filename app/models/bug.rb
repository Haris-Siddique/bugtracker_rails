class Bug < ApplicationRecord 

  belongs_to :project

  belongs_to :developer, class_name: 'User'
  belongs_to :qa, class_name: 'User'
  
end