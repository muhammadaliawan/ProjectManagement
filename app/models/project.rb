# frozen_string_literal: true

class Project < ApplicationRecord
  paginates_per 5

  has_and_belongs_to_many :resources, class_name: 'User'

  has_many :time_logs
  has_many :payments
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable

  belongs_to :client
  belongs_to :manager, class_name: 'User'
  belongs_to :created_by, class_name: 'User'

  validates :name, :details, presence: true

  private

  def self.get_projects(user)
    if user.admin?
      @project = Project.all
    elsif user.manager?
      @project = Project.where(manager: user).or(Project.where(created_by: user))
    elsif user.developer?
      @project = user.projects
    end
  end
end
