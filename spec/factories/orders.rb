FactoryBot.define do
  factory :order do
    client { nil }
    book { nil }
    form_of_payment { nil }
  end
end
