# frozen_string_literal: true

class Api::V1::AttachmentsController < Api::APIController
  def index
    @attachments = Attachment.all

    render json: @attachments, status: 200
  end

  def show
    @project = Project.find(params[:project_id])
    @attachment = @project.attachments.find(params[:id])

    render json: @attachment, status: 200
  end
end
