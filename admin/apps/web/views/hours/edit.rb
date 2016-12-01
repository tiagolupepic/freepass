module Web::Views::Hours
  class Edit
    include Web::View

    def form
      Form.new(:hour, routes.hour_path(id: hour.id), { hour: hour }, { method: :patch })
    end

    def submit_label
      'Salvar'
    end


    def persisted?
      true
    end
  end
end
