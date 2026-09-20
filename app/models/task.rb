class Task < ApplicationRecord
  STATUSES = %w[pending in_progress completed].freeze
  PRIORITIES = %w[low medium high].freeze

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  after_initialize :set_defaults, if: :new_record?

  scope :search, ->(query) {
    sanitized_query = ActiveRecord::Base.sanitize_sql_like(query)

    where(
      "title ILIKE :query OR description ILIKE :query",
      query: "%#{sanitized_query}%"
    )
  }

  private

  def set_defaults
    self.status ||= "pending"
    self.priority ||= "medium"
  end
end
