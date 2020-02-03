# frozen_string_literal: true

class Project < ApplicationRecord
  paginates_per 5

  has_and_belongs_to_many :resources, class_name: 'User', dependent: :destroy

  has_many :time_logs, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  belongs_to :client
  belongs_to :manager, class_name: 'User'
  belongs_to :created_by, class_name: 'User'

  validates :name, :details, presence: true

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
