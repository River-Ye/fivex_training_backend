class Task < ApplicationRecord
  validate :end_after_start
  validates :title, :content, :start_time, :end_time, presence: true

  enum status: { 'pending': 0, 'progress': 1, 'completed': 2 }

  private

  def end_after_start
    return if start_time.blank? || end_time.blank?

    if end_time < start_time
      errors.add(:end_time, :cant_end_after_start)
    end
 end
end