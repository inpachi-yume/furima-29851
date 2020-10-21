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

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :category_id, :condition_id, :postage_payer_id, :shipping_time_id, numericality: { other_than: 1 }, presence: true
  validates :prefecture_id,  numericality: { other_than: 0 }, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, inclusion: { in: 300..9_999_999 }
end
