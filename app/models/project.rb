class Project < ApplicationRecord

  has_and_belongs_to_many :users
  has_many :time_logs
  has_many :payments

  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable

end
