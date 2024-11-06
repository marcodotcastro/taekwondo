class Fighter < ApplicationRecord
  has_many :home_matches, class_name: 'Match', foreign_key: 'fighter1_id'
  has_many :away_matches, class_name: 'Match', foreign_key: 'fighter2_id'

  has_one_attached :photo

  validates :name, presence: true
  validates :weight, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def matches
    Match.where('fighter1_id = ? OR fighter2_id = ?', id, id)
  end
end