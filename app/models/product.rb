class Product < ApplicationRecord
  has_many :descriptions, dependent: :destroy
  has_many :details, through: :descriptions
  has_many :lists, through: :wholesales
  has_many :wholesales
  validates :name, presence: true
  validates_uniqueness_of :name, :scope => [:model, :brand, :color]
  validates :model, presence: true
  validates :brand, presence: true
  validates :purchase_price, presence: true, format: { with: /(\d)+.\d{0,2}/ }
  validates :storage, presence: true, format: { with: /(\d)+/ }
  validates :wholesale_labeled_price, presence: true, format: { with: /(\d)+.\d{0,2}/ }
  # include PgSearch
  # pg_search_scope :search_by,
  #   against: [ :name, :brand, :model, :category ],
  #   using: {
  #     tsearch: { prefix: true, any_word: true },
  #     tsearch: :trigram
  #   }
  searchkick word_middle: [:name, :brand, :category, :model]
  def search_data
    {
      name: name,
      model: model,
      brand: brand,
      category: category
    }
  end
end
