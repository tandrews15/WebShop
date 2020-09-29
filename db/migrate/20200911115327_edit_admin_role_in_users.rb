class EditAdminRoleInUsers < ActiveRecord::Migration[6.0]
  def change

    def up
      change_column :users, :admin, :boolean, default: false
    end
    
    def down
      change_column :users, :admin, :boolean, default: false
    end

  end
end
