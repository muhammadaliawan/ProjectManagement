# frozen_string_literal: true

class PaymentSerializer < ApplicationSerializer
  attributes :amount, :date, :details

  belongs_to :project
end
