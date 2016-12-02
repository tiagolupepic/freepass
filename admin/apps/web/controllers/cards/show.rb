module Web::Controllers::Cards
  class Show
    include Web::Action
    expose :card

    def call(params)
      @card = Card.find(params[:id])
    end
  end
end
