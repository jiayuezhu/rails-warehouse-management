class Buyer < ApplicationRecord
  has_many :lists
  validates :name, presence: true

  searchkick word_middle: [:name, :address, :company, :notes, :website]
  def search_data
    {
      name: name,
      address: address,
      company: company,
      notes: notes,
      website: website
    }
  end
end
