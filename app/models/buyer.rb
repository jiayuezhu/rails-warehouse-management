class Buyer < ApplicationRecord
  has_many :lists
  belongs_to :user
  validates :name, presence: true
  include PgSearch
  pg_search_scope :search_buyers,
    against: {
      name: "A",
      company: "B",
      email: "C",
      notes: "D"
    },
    :using => {
      # tsearch: {any_word: true, prefix: true, dictionary: "english"}
      :tsearch => {:prefix => true, :any_word => true},
      :trigram => {:threshold => 0.1}
    }
end
