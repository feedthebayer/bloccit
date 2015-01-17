class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }
  validates :user, presence: true

  after_create :email_users_who_favorited_this_post

  private

  def email_users_who_favorited_this_post
    self.post.favorites.each do |favorite|
      if should_email_user_for?(favorite)
        FavoriteMailer(favorite.user, post, self).deliver
      end
    end
  end

  def should_email_user_for?(favorite)
    favorite.user.email_favorites? && !user_who_created_this_comment?(favorite)
  end

  def user_who_created_this_comment?(favorite)
    user_id == favorite.user_id
  end
end
