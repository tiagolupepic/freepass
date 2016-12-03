module Web::Controllers::Cards
  class Edit
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :card

    def call(params)
      @card = Card.find(params[:id])
    end
  end
end
