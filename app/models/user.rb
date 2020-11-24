class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # お気に入りにしている掲示板を取得する
  has_many :bookmarks_boards, through: :bookmarks, source: :board

  mount_uploader :avatar, AvatarUploader

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true, presence: true

  validates :last_name, presence: true, length: { maximum: 255}
  validates :first_name, presence: true, length: { maximum: 255}

  # オブジェクトがユーザー自身のものか判断する
  def own?(object)
    object.user_id == id
  end

  # お気に入り追加
  # <<で引数で渡した掲示板の情報がbookmark_boardsに入っている
  def bookmark(board)
    bookmarks_boards << board
  end

  # お気に入りを外す
  def unbookmark(board)
    bookmarks_boards.delete(board)
  end

  # お気に入り登録しているか判定するメソッド
  def bookmark?(board)
    bookmarks_boards.include?(board)
  end
end
