FactoryBot.define do
  factory :client do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { "email@teste.com"}
  end
end
