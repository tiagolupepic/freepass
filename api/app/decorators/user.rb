require_relative 'base'

class UserDecorator < BaseDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :full_name, :phone, :address, :email, :cpf

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:        id,
      full_name: full_name,
      phone:     phone,
      address:   address,
      email:     email,
      cpf:       cpf,
      admin:     false,
      state:     state_name(model.state),
      errors:    errors
    }
  end
end
