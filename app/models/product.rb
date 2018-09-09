class Product < ApplicationRecord
  has_many :descriptions, dependent: :destroy
  has_many :details, through: :descriptions
  has_many :lists, through: :wholesales
  has_many :wholesales
  belongs_to :user
  validates :name, presence: true
  validates_uniqueness_of :name, :scope => [:model, :brand, :color]
  validates :brand, presence: true
  validates :color, length: { maximum: 20 }
  validates :purchase_price, presence: true, format: { with: /(\d)+.\d{0,2}/ }
  validates :storage, presence: true, format: { with: /(\d)+/ }
  validates :wholesale_labeled_price, presence: true, format: { with: /(\d)+.\d{0,2}/ }
  include PgSearch
  pg_search_scope :search_by,
    against: {
      name: "A",
      brand: "B",
      model: "C",
      category: "D"
    },
    :using => {
      # tsearch: {any_word: true, prefix: true, dictionary: "english"}
      :tsearch => {:dictionary  => 'english', :prefix => true, :any_word => true, highlight: {
                        StartSel: '<start>',
                        StopSel: '<stop>',
                        MaxWords: 123,
                        MinWords: 456,
                        ShortWord: 4,
                        HighlightAll: true,
                        MaxFragments: 3,
                        FragmentDelimiter: '&hellip;'
                      }},
      :trigram => {:threshold => 0.05}
    }
end
