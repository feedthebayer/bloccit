class Vote
  include Mongoid::Document
  field :value, type: Integer, default: 0
  field :user_id, type: Integer
  field :post_id, type: Integer
  # belongs_to :user
  # belongs_to :post
  validates :value, inclusion: { in: [-1, 1],
                                 message: "%{value} is not a valid vote." }

  def user
    User.find(self.user_id)
  end

  def post
    Post.find(self.post_id)
  end

  def max?
    value == 1
  end

  def min?
    value == -1
  end

  after_save :update_post

  private

  def update_post
    post.update_rank
  end
end
