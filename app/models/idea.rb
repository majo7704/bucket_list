class Idea < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum:75 }

  belongs_to :user

  has_many :comments

  has_and_belongs_to_many :users

  scope :most_recent, -> { order(created_at: :desc).limit(3)}
  

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    Idea.where('title LIKE ?', wildcard_filter).or(where('description LIKE ?', wildcard_filter))
  end

end
