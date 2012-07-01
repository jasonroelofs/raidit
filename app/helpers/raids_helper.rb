module RaidsHelper
  def render_raid_calendar(presenter)
    render partial: "raids/calendar", locals: { presenter: presenter }
  end

  def option_list_of_characters(characters)
    options_from_collection_for_select(characters, :id, :name)
  end
end
