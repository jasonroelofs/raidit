module ApplicationHelper
  def normalize_name(string_to_normalize)
    (string_to_normalize || "").underscore.gsub(/[_\s]/, '')
  end
end
