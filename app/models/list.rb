class List < ApplicationRecord
  has_many :products, through: :wholesales
  has_many :wholesales, dependent: :destroy
  belongs_to :buyer
  belongs_to :user
  # belongs_to :seller
  validates :bill_id, presence: true
  validates :buyer_id, presence: true
  # validates :seller, presence: true, unless: :buyer
  # belongs_to :bills
end
