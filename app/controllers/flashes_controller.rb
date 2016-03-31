class FlashesController < ApplicationController
  def show
    ap flash_params
    render partial: 'layouts/flash', locals: flash_params
  end

  protected
  def flash_params
    params.permit(:alert_style, :message)
  end
end
