module DecoratorHelper
  def format_time(d)
    return if d.blank?
    d.strftime('%H:%M')
  end
end
