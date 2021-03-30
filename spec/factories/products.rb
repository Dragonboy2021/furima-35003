FactoryBot.define do
  factory :product do
    title { Faker::Dessert.variety }
    info { Faker::Lorem.sentence }
    category { Category.find 1 }
    quality { Quality.find 1 }
    location { Location.find 1 }
    price { 1000 }
    delivery_date { DeliveryDate.find 1 }
    delivery_fee { DeliveryFee.find 1 }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
