FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk12345678901234567' }
    postal_code = Faker::Number.number(digits: 7)
    postal_code { postal_code.to_s.insert(3, '-') }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { Faker::Address.city }
    house_number { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: 10) }
  end
end
