# frozen_string_literal: true

class User < ApplicationRecord
  paginates_per 5

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: %i[developer admin manager]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  after_initialize :set_default_role, if: :new_record?

  has_and_belongs_to_many :projects

  has_many :time_logs
  has_many :comments, as: :commentable
  has_one :attachment, as: :attachable
  has_many :comments

  validates :name, :address, :cnic, :phone_number, presence: true
  validates :name, length: { in: 5..15 }
  validates :cnic, length: { is: 13 }
  validates :address, length: { maximum: 100 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  scope :developers, -> { where role: 'developer' }
  scope :managers, -> { where role: 'manager' }
  scope :admins, -> { where role: 'admin' }
  scope :except_current_user, ->(user) { where.not(id: user) }

  def set_default_role
    self.role ||= :developer
  end

  def active_for_authentication?
    super && enable?
  end
end
