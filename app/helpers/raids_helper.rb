module RaidsHelper
  def render_raid_calendar(presenter)
    render partial: "raids/calendar", locals: { presenter: presenter }
  end
end