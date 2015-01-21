FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now

    factory :user_with_post_and_comment do
      transient do
        count 1
      end
      after(:build) do |user, evalulator|
        create_list(:post, evalulator.count, user: user)
        create_list(:comment, evalulator.count, user: user)
      end
    end
  end
end
