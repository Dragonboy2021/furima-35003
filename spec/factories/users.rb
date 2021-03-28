FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    gimei = Gimei.new
    first_name { gimei.first.kanji }
    last_name { gimei.last.kanji }
    phonetic_first_name { gimei.first.katakana }
    phonetic_last_name { gimei.last.katakana }
    birthday { Faker::Date.birthday }
  end
end
