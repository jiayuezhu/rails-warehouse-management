class Detail < ApplicationRecord
  has_many :products, through: :descriptions
  has_many :descriptions, dependent: :destroy
  belongs_to :user
end
