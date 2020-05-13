# frozen_string_literal: true

require 'date'
require 'broadcast_calendar/version'

# This module contains methods for work with the standardized broadcast (radio, television) calendar.
module BroadcastCalendar
  module_function

  def dates_for(month, year)
    # find the monday of the first week of the month
    beginning = Date.civil(year, month, 1)

    beginning -= if (wday = beginning.wday).zero?
                   6
                 else
                   wday - 1
                 end

    ending = Date.civil(year, month, -1)
    ending -= ending.wday # broadcast calendar always ends on Sunday

    beginning..ending
  end

  ##
  # Returns the date range for the specefied broadcast week for the specefied broadcast year
  def dates_for_week(year, week_num)
    calendar_year_start = dates_for(1, year).first
    calendar_year_end   = dates_for(12, year).last
    calendar_range      = calendar_year_start..calendar_year_end

    dates = calendar_range.each_slice(7).take(week_num).last
    dates.first..dates.last
  end

  def weeks_for(month, year)
    dates_for(month, year).each_slice(7).collect { |s| s.first..s.last }
  end

  def month_and_year_for(date)
    range = dates_for(date.month, date.year)

    month = date.month
    year = date.year

    return [month, year] if range.cover?(date)

    month += (date <=> range.begin)
    return [12, year - 1] if month < 1
    return [1, year + 1] if month > 12

    [month, year]
  end
end
