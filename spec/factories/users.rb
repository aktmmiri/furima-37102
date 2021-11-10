FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.unique.free_email}
    password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    password {password}
    password_confirmation {password}
    japanese_name = Gimei.name
    last_name {japanese_name.last.kanji}
    first_name {japanese_name.first.kanji}
    last_name_kana {japanese_name.last.katakana}
    first_name_kana {japanese_name.first.katakana}
    birth_date {Faker::Date.birthday(min_age: 10, max_age: 90)}
  end
end