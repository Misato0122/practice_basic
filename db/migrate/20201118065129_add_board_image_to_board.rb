class AddBoardImageToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :board_image, :string
  end
end
