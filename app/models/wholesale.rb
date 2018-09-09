class Wholesale < ApplicationRecord
  belongs_to :product
  belongs_to :list
  belongs_to :user

  # def product_name
  #   product.try(:name)
  # end

  # def product_name=(name)
  #   self.product = Product.find_by(name: name)
  # end
end
