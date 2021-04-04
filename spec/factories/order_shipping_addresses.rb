FactoryBot.define do
  factory :order_shipping_address do
    postal_address {"243-3323"}
    state_id {1}
    city {"品川区"}
    street {"上大崎1-2-3"}
    building {"ライオンズマンション"}
    phone {'07055436345'}
    token {"tok_abcdefasdf89jdl"}
  end
end
