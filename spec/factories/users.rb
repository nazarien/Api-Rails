FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "name#{n}@gmail.com"}
    password {'123456'}
    password_confirmation {'123456'}
    role { 'author' }

    trait :with_articles do
      after :create do |user|
        articles = FactoryBot.create_list :article, 2

        user.articles << articles
        user.save
      end
    end
  end
  factory :role, parent: :user do
    role { 'user' }
  end
end
