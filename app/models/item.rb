class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :shipping_time
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :user_id
    validates :name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :image
    validates :category_id, :condition_id, :postage_payer_id, :shipping_time_id, numericality: { other_than: 1 }
    validates :prefecture_id,  numericality: { other_than: 0 }
    validates :price, format: { with: /\A[0-9]+\z/ }, inclusion: { in: 300..9_999_999 }
  end
end
