class UserDecorator
  extend Forwardable

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
      errors:    errors
    }
  end

  private

  def errors
    return if model.valid?
    model.errors.details
  end
end
