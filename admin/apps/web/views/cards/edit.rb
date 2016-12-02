module Web::Views::Cards
  class Edit
    include Web::View

    def form
      Form.new(:card, routes.card_path(id: card.id), { card: card }, { method: :patch })
    end

    def submit_label
      'Salvar'
    end


    def persisted?
      true
    end
  end
end
