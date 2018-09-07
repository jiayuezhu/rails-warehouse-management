class Bill < ApplicationRecord
  has_many :lists
  include PgSearch
  pg_search_scope :search_bills,
    against: {
      created_at: "A",
      notes: "B"
    },
    :using => {
      # tsearch: {any_word: true, prefix: true, dictionary: "english"}
      :tsearch => {:prefix => true, :any_word => true},
      :trigram => {:threshold => 1}
    }
end
