module Web::Views::Hours
  class New
    include Web::View

    def form
      Form.new(:hour, routes.hours_path)
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
