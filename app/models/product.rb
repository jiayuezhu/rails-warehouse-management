class Product < ApplicationRecord
  has_many :descriptions, dependent: :destroy
  has_many :details, through: :descriptions
  has_many :lists, through: :wholesales
  has_many :wholesales
end
