class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[developer admin manager client]

  validates :name, :address, :cnic, :phone_number, presence: true

  has_and_belongs_to_many :projects
  has_many :time_logs
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable

end
