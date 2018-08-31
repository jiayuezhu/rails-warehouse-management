class List < ApplicationRecord
  has_many :products, through: :wholesales
  has_many :wholesales, dependent: :destroy
  # belongs_to :bills
end
