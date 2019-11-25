class Task < ApplicationRecord
  enum status: { 'pending': 0, 'progress': 1, 'completed': 2 }

  validate :end_after_start
  validates :title, :content, :start_time, :end_time, presence: true
  validates :status, inclusion: { in: statuses }
  
  scope :end_time, -> { order(end_time: :desc) }

  private

  def end_after_start
    return if start_time.blank? || end_time.blank?

    if end_time < start_time
      errors.add(:end_time, :cant_end_after_start)
    end
 end

 def self.search_params(search = nil)
   return all if search.nil?
   where(['title || status LIKE ?', "%#{search}%"])
 end
end