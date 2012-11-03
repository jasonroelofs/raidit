module FlashMessagesHelper

  def render_flash_messages
    if flash[:login_error]
      error "Unable to log you in with those credentials"
    end
  end

  def error(message)
    content_tag :div, :class => "alert alert-error" do
      message
    end
  end

end
