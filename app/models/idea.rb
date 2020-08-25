class Idea < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum:75 }


  def self.most_recent()
    all.order(created_at: :desc).limit(3)
  end

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    Idea.where('title LIKE ?', wildcard_filter).or(where('description LIKE ?', wildcard_filter))
  end

end
