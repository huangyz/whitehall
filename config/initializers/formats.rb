Date::DATE_FORMATS[:long_ordinal]        = "%e %B %Y"
Date::DATE_FORMATS[:short_ordinal]       = "%B %Y"
Date::DATE_FORMATS[:uk_short]            = "%d/%m/%Y"
Time::DATE_FORMATS[:long_ordinal]        = "%e %B %Y %H:%M"
Time::DATE_FORMATS[:one_month_precision] = "%B %Y"
Time::DATE_FORMATS[:two_month_precision] = lambda do |time|
   opening_month = time.strftime("%B")
   (time+ 1.month).strftime("#{opening_month} to %B %Y")
  end
