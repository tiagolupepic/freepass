module Web::Controllers::Cards
  class Create
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :card

    def call(params)
      @card = Card.create(params[:card])

      if @card.persisted?
        redirect_to routes.card_path(@card.id)
      else
        self.status = 422
      end
    end
  end
end
