require_relative 'base'

class PeriodDecorator < BaseDecorator
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
      start_at: format_date(start_at),
      end_at:   format_date(end_at),
      errors:   errors
    }
  end
end

