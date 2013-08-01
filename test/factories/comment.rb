FactoryGirl.define do
  factory :comment do
    commenter "Commenter"
    body "Body"
    association :post, factory: :post
  end
end