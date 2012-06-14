Then %r{^I should see a calendar for the next (\d+) weeks$} do |number_of_weeks|
  number_of_weeks.to_i.times do |i|
    today = Date.today + i.weeks
    beginning_of_week = today.beginning_of_week.to_date
    end_of_week = today.end_of_week.to_date

    (beginning_of_week..end_of_week).each do |weekday|
      assert page.has_content?(weekday.day.to_s), "Unable to find #{weekday} on the page"
    end
  end
end