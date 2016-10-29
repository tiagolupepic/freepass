module DecoratorHelper
  def format_time(d)
    return if d.blank?
    d.to_formatted_s(:time)
  end
end
