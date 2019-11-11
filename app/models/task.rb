class Task < ApplicationRecord
  belongs_to :user
  has_many :tasktags
  has_many :tags, through: :tasktags
end