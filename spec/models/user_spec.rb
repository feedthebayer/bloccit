require 'rails_helper'

describe User do

  describe '#favorited(post)' do

    before do
      @post = create(:post)
      @user = create(:user)
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect(@user.favorited(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = @user.favorites.where(post: @post).create

      expect(@user.favorited(@post)).to eq(favorite)
    end
  end

  describe ".top_rated" do

    before do
      @user1 = create(:user_with_post_and_comment)
      post = @user1.posts.first

      @user2 = create(:user_with_post_and_comment)
      post = @user2.posts.first
      create(:comment, user: @user2, post: post)
    end

    it "returns users ordered by comments + posts" do
      expect(User.top_rated).to eq([@user2, @user1])
    end

    it "stores a 'posts_count' on user" do
      users = User.top_rated
      expect(users.first.posts_count).to eq(1)
    end

    it "stores a 'comments_count' on user" do
      users = User.top_rated
      expect(users.first.comments_count).to eq(2)
    end
  end
end
