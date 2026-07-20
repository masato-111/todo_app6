class Professor < ApplicationRecord
    validates :title, presence: true 
    validates :image, content_type: ['image/png','image/jpeg','image/gif']
    has_one_attached :image
end
