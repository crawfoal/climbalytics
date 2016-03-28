module FlashHelper
  def render_flash
    flash_array = []
    # Don't display the whole flash, sometimes stuff that we don't want or need
    # to display to the user is added to the flash (e.g. Devise does this). If
    # you want to display a new type (or you are extending this to display
    # multiple messages per type), please continue whitelist the types (e.g. via
    # the types_to_styles hash as I'm currently doing)
    types_to_styles.each do |type, style|
      flash_array << render(partial: '/layouts/flash', locals: {alert_style: style, message: flash[type]}) unless flash[type].blank?
    end
    flash_array.join('').html_safe
  end
  def types_to_styles
    {alert: :error, notice: :success, warning: :alert}
  end
end
