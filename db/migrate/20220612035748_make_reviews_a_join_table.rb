class MakeReviewsAJoinTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :name, :string
    add_reference :reviews, :user, index: true, foreign_key: true, null: false
    Review.delete_all
  end
end
