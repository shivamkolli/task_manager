class Task < ApplicationRecord
  belongs_to :user

  STATUSES = %w[pending in_progress completed].freeze
  PRIORITIES = %w[low medium high].freeze

  scope :search, ->(query) {
    sanitized_query = ActiveRecord::Base.sanitize_sql_like(query)

    where(
      "title ILIKE :query OR description ILIKE :query",
      query: "%#{sanitized_query}%"
    )
  }

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.status ||= "pending"
    self.priority ||= "medium"
  end
end
