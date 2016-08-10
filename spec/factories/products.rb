FactoryGirl.define do
  factory :product do
    store :store_id
    owner :owner_id
    title "MyString"
    description "MyText"
    sku 1
    price "9.99"
    count 1
  end
end
