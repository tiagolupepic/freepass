class CardDecorator
  extend Forwardable

  def_delegators :@model, :id, :number

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:        id,
      number:    number,
      full_name: user.full_name,
      email:     user.email
    }
  end

  private

  def user
    model.user
  end
end
