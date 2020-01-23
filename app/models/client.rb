# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 5

  has_many :projects

  validates :name, :email, :address, presence: true
  validates :name, length: { in: 5..15 }
end
