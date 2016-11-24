require_relative 'base'

class CardDecorator < BaseDecorator
  extend Forwardable

  def_delegators :@model, :id, :number, :user_id

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:        id,
      number:    number,
      full_name: user.full_name,
      email:     user.email,
      user_id:   user_id,
      errors:    errors
    }
  end

  private

  def user
    model.user
  end
end
