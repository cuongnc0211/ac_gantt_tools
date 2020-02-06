module ApplicationHelper
  def weekend_class date
    return 'today' if date == Date.today

    'weekend' if date.saturday? || date.sunday?
  end

  def today_class date
    return 'today' if date == Date.today
  end
end
