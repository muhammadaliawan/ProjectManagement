# frozen_string_literal: true

class ProjectSerializer < ApplicationSerializer
  attributes :id,:name, :details, :total_payments, :hours_logged, :client, :manager, :created_by

  has_many :payments
end
