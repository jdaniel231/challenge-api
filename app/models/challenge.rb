class Challenge < ApplicationRecord
  validates :title, :description, :start_date, :end_date, presence: true

  belongs_to :user
end
