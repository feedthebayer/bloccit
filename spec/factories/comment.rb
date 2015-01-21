FactoryGirl.define do
  factory :comment do
    body "This is a new test comment"
    user
    post

    after(:build) do |comment|
      comment.class.skip_callback(:create, :after,
                                  :email_users_who_favorited_this_post)
    end
  end
end
