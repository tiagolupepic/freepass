require_relative 'base'

class HourDecorator < BaseDecorator
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
      start_at: format_time(start_at),
      end_at:   format_time(end_at),
      days:     days,
      errors:   errors
    }
  end

  private

  def days
    return [] if model.days.nil?
    model.days.delete_if { |_,v| v == "false" }.keys
  end
end
