module Web::Views::Hours
  class Create
    include Web::View
    template 'hours/new'

    def form
      Form.new(:hour, routes.hours_path, { hour: hour })
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
