require_relative 'base'

class UserDecorator < BaseDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :full_name, :phone, :address, :email, :cpf, :state

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:            id,
      full_name:     full_name,
      phone:         phone,
      address:       address,
      email:         email,
      cpf:           cpf,
      admin:         admin,
      state:         state,
      state_name:    state_name(state),
      periods:       periods,
      period_ids:    model.period_ids,
      period_names:  period_names,
      holidays:      holidays,
      holiday_ids:   model.holiday_ids,
      holiday_names: holiday_names,
      errors:        errors
    }
  end

  private

  def admin
    model.role == 'admin'
  end

  def period_names
    return if model.periods.empty?
    model.periods.map(&:name).join(', ')
  end

  def periods
    return [] if model.periods.empty?
    model.periods.collect { |h| [h.name, h.id] }
  end

  def holiday_names
    return if model.holidays.empty?
    model.holidays.map(&:name).join(', ')
  end

  def holidays
    return [] if model.holidays.empty?
    model.holidays.collect { |h| [h.name, h.id] }
  end
end
