module Web::Views::Cards
  class Create
    include Web::View
    template 'cards/new'

    def form
      Form.new(:card, routes.cards_path, { card: card })
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
