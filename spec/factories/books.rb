FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    price { Faker::Number.within(range: 10..70) }
    author
  end
end
