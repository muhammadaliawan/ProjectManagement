# frozen_string_literal: true

class ProjectSerializer < ApplicationSerializer
  attributes :id,:name, :details, :total_payments, :hours_logged, :client, :manager, :created_by

  has_many :resources, class_name: 'User'
  has_many :payments

  belongs_to :manager, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  
  def manager
    {
      Name: object.manager.name,
      Email: object.manager.email
    }
  end

  def created_by
    {
      Name: object.created_by.name,
      Email: object.created_by.email
    }
  end
end
