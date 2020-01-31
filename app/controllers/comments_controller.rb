# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = @project.comments.new
  end

  def edit; end

  def create
    @comment = @project.comments.new(comment_params)
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def set_project
    @project = Project.includes(:comments).find(params[:project_id])
  end

  def set_comment
    @comment = @project.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:message, :commentable_id, :commentable_type, :commenter_id)
  end
end
