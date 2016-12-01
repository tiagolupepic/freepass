module Web::Views::Holidays
  class Edit
    include Web::View

    def form
      Form.new(:holiday, routes.holiday_path(id: holiday.id), { holiday: holiday }, { method: :patch })
    end

    def submit_label
      'Salvar'
    end


    def persisted?
      true
    end
  end
end
