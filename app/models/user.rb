class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  def voted(post)
    votes.where(post_id: post.id).first
  end

  def voted_up?(post)
    if vote = voted(post)
      vote.max?
    else
      nil
    end
  end

  def voted_down?(post)
    if vote = voted(post)
      vote.min?
    else
      nil
    end
  end

  def self.top_rated
    self.select('users.*')
        .select('COUNT(DISTINCT comments.id) AS comments_count')
        .select('COUNT(DISTINCT posts.id) AS posts_count')
        .select('COUNT(DISTINCT posts.id) + COUNT(DISTINCT comments.id) AS rank')
        .joins(:posts)
        .joins(:comments)
        .group('users.id')
        .order('rank DESC')
  end
end
