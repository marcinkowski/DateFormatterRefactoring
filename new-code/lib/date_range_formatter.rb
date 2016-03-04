require "date"
require "fixnum"

class DateRangeFormatter
  def initialize(start_date, end_date, start_time = nil, end_time = nil)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @start_time = start_time
    @end_time = end_time
  end

  def to_s
    start_day = @start_date.day.ordinalize
    start_month, start_year = @start_date.strftime("%B %Y").split
    end_day = @end_date.day.ordinalize
    end_month, end_year = @end_date.strftime("%B %Y").split

    case true
      when @start_time && @end_time && @start_date == @end_date
        "#{start_day} #{start_month} #{start_year} at #{@start_time} to #{@end_time}"
      when @start_time && @start_date == @end_date
        "#{start_day} #{start_month} #{start_year} at #{@start_time}"
      when @end_time && @start_date == @end_date
        "#{start_day} #{start_month} #{start_year} until #{@end_time}"
      when @start_date == @end_date
        "#{start_day} #{start_month} #{start_year}"
      when !!(@start_time && @end_time)
        "#{start_day} #{start_month} #{start_year} at #{@start_time} - #{end_day} #{end_month} #{end_year} at #{@end_time}"
      when !!@start_time
        "#{start_day} #{start_month} #{start_year} at #{@start_time} - #{end_day} #{end_month} #{end_year}"
      when !!@end_time
        "#{start_day} #{start_month} #{start_year} - #{end_day} #{end_month} #{end_year} at #{@end_time}"
      when start_month == end_month && start_year == end_year
        "#{start_day} - #{end_day} #{end_month} #{end_year}"
      when start_year == end_year
        "#{start_day} #{start_month} - #{end_day} #{end_month} #{end_year}"
      else
        "#{start_day} #{start_month} #{start_year} - #{end_day} #{end_month} #{end_year}"
    end
  end
end