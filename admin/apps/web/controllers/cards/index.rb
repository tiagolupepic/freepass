module Web::Controllers::Cards
  class Index
    include Web::Action
    expose :cards

    def call(params)
      @cards = params[:q].present? ? Card.where(q: params[:q]) : Card.all
    end
  end
end
