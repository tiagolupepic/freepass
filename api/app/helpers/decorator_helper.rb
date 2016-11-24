module DecoratorHelper
  def format_time(d)
    return if d.blank?
    d.to_formatted_s(:time)
  end

  def format_date(d)
    return if d.blank?
    d.strftime('%d/%m/%Y')
  end
end
