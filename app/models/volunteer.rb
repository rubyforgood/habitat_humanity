class Volunteer < ActiveRecord::Base
  has_many :shifts, dependent: :destroy

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
end
