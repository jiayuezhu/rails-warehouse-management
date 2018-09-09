class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true, format: { with: /\A.*@.*\.com\z/ }
  has_many :products, dependent: :destroy
  has_many :buyers, dependent: :destroy
  has_many :details, dependent: :destroy
  has_many :descriptions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :wholesales, dependent: :destroy
end
