class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  mount_uploader :board_image, BoardImageUploader

  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 65535 }, presence: true

  scope :bookmarked_by, -> user {
    joins(:bookmarks).where('bookmark.user_id = ?', user_id)
  }

end
