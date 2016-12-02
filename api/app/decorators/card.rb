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
      full_name: user.try(:full_name),
      email:     user.try(:email),
      user_id:   user_id,
      user:      user_option,
      errors:    errors
    }
  end

  private

  def user
    model.user
  end

  def user_option
    return {} unless user
    [[user.full_name, user_id]]
  end
end
