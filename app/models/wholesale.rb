class Wholesale < ApplicationRecord
  belongs_to :product
  belongs_to :list

  # def product_name
  #   product.try(:name)
  # end

  # def product_name=(name)
  #   self.product = Product.find_by(name: name)
  # end
end
