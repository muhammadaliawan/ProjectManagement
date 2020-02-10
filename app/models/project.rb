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

  def self.top_projects
    Project.order(total_payments: :desc).limit(5)
  end

  def self.bottom_projects
    Project.order(total_payments: :asc).limit(5)
  end

  def self.search_projects(params)
    if params[:search].blank?
      @project
    else
      @parameter = params[:search].downcase
      @results = @project.where("lower(name) LIKE :search", search: @parameter)
    end
  end
end
