module Web::Views::Periods
  class Edit
    include Web::View

    def form
      Form.new(:period, routes.period_path(id: period.id), { period: period }, { method: :patch })
    end

    def submit_label
      'Salvar'
    end


    def persisted?
      true
    end
  end
end
