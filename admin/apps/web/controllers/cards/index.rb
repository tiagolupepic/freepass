module Web::Controllers::Cards
  class Index
    include Web::Action
    expose :cards

    def call(params)
      @cards = Card.all
    end
  end
end
