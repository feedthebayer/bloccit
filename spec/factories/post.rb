FactoryGirl.define do
  factory :post do
    title "Post Title"
    body "This is a longer post body."
    user
    topic { Topic.create(name: 'Topic Name') }
  end
end
