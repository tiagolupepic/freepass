class HourDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :name, :start_at, :end_at

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:       id,
      name:     name,
      start_at: format_datetime(start_at),
      end_at:   format_datetime(end_at),
      days:     days
    }
  end

  private

  def days
    model.days.delete_if { |_,v| v == "false" }.keys
  end
end
