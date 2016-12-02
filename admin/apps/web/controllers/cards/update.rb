module Web::Controllers::Cards
  class Update
    include Web::Action
    expose :card

    def call(params)
      @card = Card.find(params[:id])

      if @card.update_attributes(params[:card])
        redirect_to routes.card_path(@card.id)
      else
        self.status = 422
      end
    end
  end
end
