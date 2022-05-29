class Deadline < ApplicationRecord
  belongs_to :carrier
  validates :max_distance, :min_distance, :deadline_days, presence: true
end
