module Web::Controllers::Events
  class Index
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :events

    def call(params)
      @events = Event.all
    end
  end
end
