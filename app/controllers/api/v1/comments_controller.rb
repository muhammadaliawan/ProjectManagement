# frozen_string_literal: true

class Api::V1::CommentsController < Api::ApiController
  def index
    @comments = Comment.all
    success_response(@comments, :ok)
  end

  def show
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])
    success_response(@comments, :ok)
  end
end
