module ApplicationHelper
  def time_format(t)
    # dates = %w(Sun Mon Tue Wed Thu Fri Sat)
    # "#{dates[t.wday]} #{t.month}/#{t.day}/#{t.year % 100} #{t.hour}:#{t.min}"

    t.strftime("%a %d %b %Y %I:%M %p")
  end

  def fix_url(url)
    if url
      url.match(/^https?:\/\//) ? url : "http://#{url}"
    else
      "/"
    end
  end
end
