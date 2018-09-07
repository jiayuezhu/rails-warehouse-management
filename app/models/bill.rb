class Bill < ApplicationRecord
  has_many :lists
  searchkick word_middle: [:created_at, :notes]
  def search_data
    {
      notes: notes,
      created_at: created_at.strftime("%Y-%m-%d"),
    }
  end
end
