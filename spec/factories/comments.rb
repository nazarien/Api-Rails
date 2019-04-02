FactoryBot.define do
  factory :comment do
    commenter { "MyString" }
    body { "MyText" }
    
    trait :for_user do
      association(:commentable, factory: :user)
    end

    trait :for_article do
      association(:commentable, factory: :article)
    end
  end
end
