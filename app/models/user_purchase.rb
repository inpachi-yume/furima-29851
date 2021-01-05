class UserPurchase
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number

  with_options presence: true do 
    validates :item_id
    validates :user_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture, numericality: { other_than: 0 }
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
  end

  def save
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, purchase: purchase.id)
    Purchase.create(item.id: item.id, user.id: user.id)
  end

end