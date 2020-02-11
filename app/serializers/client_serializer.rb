# frozen_string_literal: true

class ClientSerializer < ApplicationSerializer
  attributes :id, :name, :email, :address

  has_many :projects
end
