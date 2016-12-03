require_relative 'base'

class EventDecorator
  extend Forwardable
  include DecoratorHelper

  def_delegators :@model, :id, :created_at

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:        id,
      name:      event_name,
      status:    event_status,
      event_at:  format_datetime(created_at),
      user_name: user.full_name,
      context:   model.card_number
    }
  end

  private

  def event_status
    names.last == "true" ? 'Autorizado' : 'Não Autorizado'
  end

  def event_name
    case names.first.to_s
    when 'card'
      'Cartão / RFID'
    when 'admin'
      'Administrador'
    when 'user'
      'Usuário'
    end
  end

  def user
    model.user
  end

  def names
    @names ||= model.name.split('.')
  end
end
