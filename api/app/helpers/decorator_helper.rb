module DecoratorHelper
  def format_datetime(d)
    d.utc.to_s(:iso8601)
  end
end
