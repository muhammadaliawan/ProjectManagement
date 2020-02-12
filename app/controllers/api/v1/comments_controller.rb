# frozen_string_literal: true

class Api::V1::CommentsController < Api::ApiController
  before_action :set_project
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = Comment.all
    authorize @comments, class_name: CommentPolicy
    success_response(@comments)
  end

  def show
    authorize @comment, class_name: CommentPolicy
    success_response(@comments)
  end

  def create
    @comment = @project.comments.new(comment_params)
    @comment.commenter = current_user
    authorize @comment, class_name: CommentPolicy

    if @comment.save
      success_response(@comment, :created)
    else
      failure_response(@comment.errors)
    end
  end

  def update
    authorize @comment, class_name: CommentPolicy

    if @comment.update(comment_params)
      success_response(@comment, :updated)
    else
      failure_response(@comment.errors)
    end
  end

  def destroy
    authorize @comment, class_name: CommentPolicy

    if @comment.destroy
      success_response(@comment, :deleted)
    else
      failure_response(@comment.errors)
    end
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
