# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = @project.comments.new
    authorize @comment
  end

  def edit
    authorize @comment
  end

  def create
    @comment = @project.comments.new(comment_params)
    @comment.commenter = current_user
    authorize @comment
    @success = @comment.save
  end

  def update
    authorize @comment
    @comment.update(comment_params)
  end

  def destroy
    authorize @comment
    @success = @comment.destroy
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = @project.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
