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
      id:         id,
      full_name:  full_name,
      phone:      phone,
      address:    address,
      email:      email,
      cpf:        cpf,
      admin:      false,
      state:      state,
      state_name: state_name(state),
      errors:     errors
    }
  end
end
