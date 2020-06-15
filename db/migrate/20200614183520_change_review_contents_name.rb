class ChangeReviewContentsName < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :contents, :content
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
