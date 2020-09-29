class AddPhotoToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :photoUrl, :string
  end
end
