class RenameAdressToAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :carriers, :adress, :address
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
