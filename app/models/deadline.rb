class Deadline < ApplicationRecord
  belongs_to :carrier
  validates :max_distance, :min_distance, :deadline_days, :carrier, presence: true
end
