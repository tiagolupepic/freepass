module Web::Views::Periods
  class New
    include Web::View

    def form
      Form.new(:period, routes.periods_path)
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
