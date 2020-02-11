# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :name, :email

  has_many :projects
  has_many :time_logs
  has_one :attachment, as: :attachable
end
