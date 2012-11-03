module FlashMessagesHelper

  def render_flash_messages
    flash.now[:error] = "Unable to log you in with those credentials" if flash[:login_error]

    [ error(flash[:error]), notice(flash[:notice]) ].flatten.join(" ").html_safe
  end

  def error(message)
    content_tag :div, :class => "alert alert-error" do
      message
    end if message.present?
  end

  def notice(message)
    content_tag :div, :class => "alert alert-info" do
      message
    end if message.present?
  end

end
