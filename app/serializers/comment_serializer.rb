# frozen_string_literal: true

class CommentSerializer < ApplicationSerializer
  attributes :message

  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'
end
