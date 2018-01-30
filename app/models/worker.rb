class Worker < ApplicationRecord
  has_many :shifts, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  validates :status, presence: true, inclusion: { in: %w(medic interne interim),
                                     message: "%{value} is not a valid status" }
end
