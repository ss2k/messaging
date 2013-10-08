module ApplicationHelper  
  def proper_time(t)
    t.strftime("%I:%M%p on %m/%d/%Y")
  end
end
