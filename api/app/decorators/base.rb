class BaseDecorator

  private

  def errors
    return if model.valid?
    model.errors.details
  end
end
