# frozen_string_literal: true

class AttachmentSerializer < ApplicationSerializer
  attributes :filename

  belongs_to :attachable, polymorphic: true
end
