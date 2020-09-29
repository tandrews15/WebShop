class AddStoresToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :stores, foreign_key: true
  end
end
