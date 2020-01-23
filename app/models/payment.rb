# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :project

  validates :amount, length: { in: 5..15 }
end
