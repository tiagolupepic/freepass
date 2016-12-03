module Web::Controllers::Cards
  class New
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :card

    def call(params)
      @card = Card.new
    end
  end
end
