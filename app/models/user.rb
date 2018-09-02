class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, uniqueness: true, format: { with: /\A.*@.*\.com\z/ }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
