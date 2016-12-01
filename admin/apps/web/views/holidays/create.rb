module Web::Views::Holidays
  class Create
    include Web::View
    template 'holidays/new'

    def form
      Form.new(:holiday, routes.holidays_path, { holiday: holiday })
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end
  end
end
