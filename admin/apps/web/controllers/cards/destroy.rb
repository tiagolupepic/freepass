module Web::Controllers::Cards
  class Destroy
    include Web::Action

    def call(params)
      card = Card.find(params[:id])
      card.destroy
      redirect_to routes.cards_path
    end
  end
end
