module ApplicationHelper
  def format_time(seconds)
    Time.at(seconds).utc.strftime("%M:%S")
  end
end