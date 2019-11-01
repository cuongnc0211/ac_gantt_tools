module ApplicationHelper
  def weekend_class date
    'weekend' if date.saturday? || date.sunday?
  end
end
