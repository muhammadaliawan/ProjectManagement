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

  pg_search_scope :search, against: [:name]

  def self.fetch_current_user_projects(user)
    if user.admin?
      all
    elsif user.manager?
      where(manager: user).or(Project.where(created_by: user))
    elsif user.developer?
      user.projects
    end
  end

  def self.top_projects
    Project.order(total_payments: :desc).limit(5)
  end

  def self.bottom_projects
    Project.order(total_payments: :asc).limit(5)
  end
end
