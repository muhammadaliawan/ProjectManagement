# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project

  validates :details, presence: true
  validates :date, presence: true
  validates :amount, length: { in: 5..15 }
end
