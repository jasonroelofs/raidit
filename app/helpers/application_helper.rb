module ApplicationHelper
  def current_guild_chooser
    if current_user && current_guild
      render "shared/current_guild_chooser"
    end
  end

  def normalize_name(string_to_normalize)
    (string_to_normalize || "").underscore.gsub(/[_\s]/, '')
  end
end
