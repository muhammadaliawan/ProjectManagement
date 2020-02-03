# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project

  validates :details, :date, presence: true
  validates :amount, numericality: { other_than: 0 }
end
