# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :projects

  validates :name, :email, :address, presence: true
  validates :name, length: { in: 5..15 }
end
