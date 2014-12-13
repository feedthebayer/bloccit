class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :value, inclusion: { in: [-1, 1],
                                 message: "%{value} is not a valid vote." }

  def max?
    value == 1
  end

  def min?
    value == -1
  end
end
