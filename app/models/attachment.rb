# frozen_string_literal: true

class Attachment < ApplicationRecord
  mount_uploader :filename, AttachmentUploader
  paginates_per 5

  belongs_to :attachable, polymorphic: true
end
