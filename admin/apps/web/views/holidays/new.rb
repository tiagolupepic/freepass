module Web::Views::Holidays
  class New
    include Web::View

    def form
      Form.new(:holiday, routes.holidays_path)
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
