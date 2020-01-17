class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: %i[developer admin manager client]

  after_initialize :set_default_role, :if => :new_record?

  validates :name, :address, :cnic, :phone_number, presence: true
  validates :name, length: { in: 5..15 }
  validates :cnic, length: { is: 13 }
  validates :address, length: { maximum: 100 }

  has_and_belongs_to_many :projects

  has_many :time_logs
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable

  scope :all_clients, -> { where role: 'client' }
  scope :all_developers, -> { where role: 'developer' }
  scope :all_managers, -> { where role: 'manager' }
  scope :all_admins, -> { where role: 'admin' }
  scope :all_except, ->(user) { where.not(id: user).where.not(role: 'client') }

  def set_default_role
    self.role ||= :developer
  end

  def active_for_authentication?
    super and self.enable?
  end
end
