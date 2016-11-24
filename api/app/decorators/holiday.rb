require_relative 'base'

class HolidayDecorator < BaseDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :name, :happen_at

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:        id,
      name:      name,
      happen_at: format_date(happen_at),
      errors:    errors
    }
  end
end
