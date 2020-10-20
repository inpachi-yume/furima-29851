FactoryBot.define do
  factory :item do
    name                {'バイク'}
    description         {'よく走ります！'}
    category_id         {2}
    condition_id        {3}
    postage_payer_id    {2}
    shipping_time_id    {2}
    prefecture_id       {2}
    price               {300000}
    association :user

  end
end
