module Web::Views::Periods
  class Create
    include Web::View
    template 'periods/new'

    def form
      Form.new(:period, routes.periods_path, { period: period })
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end

    def hours
      period.try(:hours) || []
    end
  end
end
