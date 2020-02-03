# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :set_attachment, only: %i[edit update destroy]

  def new
    @attachment = Attachment.new
  end

  def edit; end

  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.save
  end

  def update
    @attachment.update(attachment_params)
  end

  def destroy
    @success = @attachment.destroy
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:filename, :attachable_id, :attachable_type)
  end
end
