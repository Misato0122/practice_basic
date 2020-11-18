class Board < ApplicationRecord
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader

  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 65535 }, presence: true
end
