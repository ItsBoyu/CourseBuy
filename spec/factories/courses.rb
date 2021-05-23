FactoryBot.define do
  factory :course do
    title { Faker::Name.name }
    slug { title.downcase }
    description { Faker::Lorem.sentence }
    status { :released }
    price { 500 }
    category

    trait :discontinued do
      status { :discontinued }
    end
  end
end