module ApplicationHelper
  def time_format(t)
    # dates = %w(Sun Mon Tue Wed Thu Fri Sat)
    # "#{dates[t.wday]} #{t.month}/#{t.day}/#{t.year % 100} #{t.hour}:#{t.min}"

    if current_user && current_user.time_zone
      t = t.in_time_zone(current_user.time_zone)
    end
    t.strftime("%a %d %b %Y %I:%M %p %Z")
  end

  def vote_obj(obj, vote_path, revote_path)
    {
                   obj: obj,
          up_vote_path: send(vote_path, obj, params: { vote: true }),
        down_vote_path: send(vote_path, obj, params: { vote: false }),
        up_revote_path: send(revote_path, obj, params: { vote: true }),
      down_revote_path: send(revote_path, obj, params: { vote: false })
    }
  end

  def fix_url(url)
    if url
      url.match(/^https?:\/\//) ? url : "http://#{url}"
    else
      "/"
    end
  end

  def is_creator?(obj)
    obj.user == current_user
  end
end
