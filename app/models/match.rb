class Match < ApplicationRecord
  belongs_to :fighter1, class_name: 'Fighter'
  belongs_to :fighter2, class_name: 'Fighter'

  validates :fighter1_id, presence: true
  validates :fighter2_id, presence: true

  enum status: { pending: 0, in_progress: 1, finished: 2 }

  before_create :set_default_values

  def time_remaining
    return duration unless started_at
    return 0 if finished?

    elapsed = Time.current - started_at
    remaining = duration - elapsed.to_i

    remaining.positive? ? remaining : 0
  end

  private

  def set_default_values
    self.duration ||= 120 # 2 minutes in seconds
    self.fighter1_score ||= 0
    self.fighter2_score ||= 0
    self.fighter1_penalties ||= 0
    self.fighter2_penalties ||= 0
    self.status ||= 'pending'
  end
end