# frozen_string_literal: true

class Api::V1::CommentsController < Api::APIController
  def index
    @comments = Comment.all

    render json: @comments, status: 200
  end

  def show
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])

    render json: @comment, status: 200
  end
end
