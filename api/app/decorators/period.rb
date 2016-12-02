require_relative 'base'

class PeriodDecorator < BaseDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :name, :start_at, :end_at, :hour_ids

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:         id,
      name:       name,
      start_at:   format_date(start_at),
      end_at:     format_date(end_at),
      hour_ids:   hour_ids,
      hour_names: hour_names,
      hours:      hours,
      errors:     errors
    }
  end

  private

  def hour_names
    return if model.hours.empty?
    model.hours.map(&:name).join(', ')
  end

  def hours
    return {} if model.hours.empty?
    model.hours.collect { |h| [h.name, h.id] }
  end
end

