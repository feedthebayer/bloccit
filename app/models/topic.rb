class Topic < ActiveRecord::Base
  extend Paginate

  has_many :posts
end
