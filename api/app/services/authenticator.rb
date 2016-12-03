class AuthenticatorService
  attr_reader :name, :params

  def initialize(name, params)
    @name, @params = name, params
  end

  def run
    create_event
    { success: strategy.valid?, user: strategy.object }
  end

  private

  def strategy
    @strategy ||= "#{name}Authenticator".classify.constantize.new(params)
  end

  def create_event
    return unless strategy.object
    Event.create name: event_name, user_id: strategy.object.id, card_number: params.inspect
  end

  def event_name
    "#{name}.auth.success.#{strategy.valid?}"
  end
end
