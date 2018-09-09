class Description < ApplicationRecord
  belongs_to :product
  belongs_to :detail
  belongs_to :user
end
