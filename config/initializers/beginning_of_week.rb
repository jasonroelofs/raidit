module TraditionalBeginningOfWeek
  def traditional_beginning_of_week
    (self - self.wday.days).midnight
  end
end

class Date
  include TraditionalBeginningOfWeek
end

class Time
  include TraditionalBeginningOfWeek
end
