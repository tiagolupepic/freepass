module Web::Views::Cards
  class New
    include Web::View

    def form
      Form.new(:card, routes.cards_path)
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
