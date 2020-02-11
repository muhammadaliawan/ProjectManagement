# frozen_string_literal: true

class Api::V1::AttachmentsController < Api::ApiController
  def index
    @attachments = Attachment.all
    success_response(@attachments, :ok)
  end

  def show
    @project = Project.find(params[:project_id])
    @attachment = @project.attachments.find(params[:id])
    success_response(@attachment, :ok)
  end
end
