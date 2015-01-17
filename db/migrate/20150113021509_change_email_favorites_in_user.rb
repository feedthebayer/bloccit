require_relative "20150111155134_add_email_permission_to_users.rb"
class ChangeEmailFavoritesInUser < ActiveRecord::Migration
  def change
    revert AddEmailPermissionToUsers

    add_column :users, :email_favorites, :boolean, default: true
  end
end
