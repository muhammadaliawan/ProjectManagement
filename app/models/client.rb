# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 5

  has_many :projects

  validates :name, :email, :address, presence: true
  validates :name, length: { in: 5..15 }

  def self.search_clients(params)
    if params[:search].blank?
      Client.all
    else
      parameter = params[:search].downcase
      @results = Client.where("lower(name) LIKE :search", search: "%#{parameter}%")
    end
  end
end
