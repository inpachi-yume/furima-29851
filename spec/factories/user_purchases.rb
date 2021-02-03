FactoryBot.define do
  factory :user_purchase do
    user_id          { 1 }
    item_id          { 1 }
    post_code        { '123-4567' }
    prefecture_id    { 1 }
    city             { '横浜市緑区' }
    house_number     { '青山1-1-1' }
    phone_number     { '09012345678' }
    token            { 'tok_7de27c906d9a38c431285a164b4d' }
  end
end
