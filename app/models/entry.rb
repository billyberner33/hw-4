class Entry < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_one_attached :uploaded_image # Enables image uploads if required

  validates :title, :description, :occurred_on, presence: true
end